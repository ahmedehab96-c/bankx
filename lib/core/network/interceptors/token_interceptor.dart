import 'package:dio/dio.dart';

import '../../constants/api_endpoints.dart';
import '../api_client.dart';

typedef AccessTokenProvider = Future<String?> Function();
typedef RefreshTokenCallback = Future<bool> Function();
typedef LogoutCallback = Future<void> Function();

/// Attaches JWT access token and handles silent refresh on 401.
class TokenInterceptor extends ApiInterceptor {
  TokenInterceptor({
    required this.getAccessToken,
    required this.refreshToken,
    required this.onLogout,
    Dio? dio,
  }) : _dio = dio ?? Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));

  final AccessTokenProvider getAccessToken;
  final RefreshTokenCallback refreshToken;
  final LogoutCallback onLogout;
  final Dio _dio;

  bool _isRefreshing = false;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401 ||
        err.requestOptions.path.contains(ApiEndpoints.refreshToken)) {
      return handler.next(err);
    }

    if (_isRefreshing) {
      return handler.next(err);
    }

    _isRefreshing = true;
    try {
      final refreshed = await refreshToken();
      if (!refreshed) {
        await onLogout();
        return handler.next(err);
      }

      final token = await getAccessToken();
      final opts = err.requestOptions;
      opts.headers['Authorization'] = 'Bearer $token';

      final response = await _dio.fetch<dynamic>(opts);
      return handler.resolve(response);
    } catch (_) {
      await onLogout();
      return handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }
}
