import 'package:dio/dio.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_response_parser.dart';
import '../dto/banking_dtos.dart';

/// REST client for all BankX banking endpoints.
class BankingApiService {
  BankingApiService(this._client);

  final ApiClient _client;

  // ── Auth ────────────────────────────────────────────────────────────────────

  Future<AuthResponseDto> login(LoginRequestDto request) async {
    final response = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.login,
      data: request.toJson(),
    );
    return AuthResponseDto.fromJson(ApiResponseParser.asMap(response.data));
  }

  Future<AuthResponseDto> register(RegisterRequestDto request) async {
    final response = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.register,
      data: request.toJson(),
    );
    return AuthResponseDto.fromJson(ApiResponseParser.asMap(response.data));
  }

  Future<AuthTokensDto> refreshToken(String refreshToken) async {
    final response = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.refreshToken,
      data: {'refresh_token': refreshToken},
    );
    return AuthTokensDto.fromJson(ApiResponseParser.asMap(response.data));
  }

  Future<void> logout() async {
    await _client.post<void>(ApiEndpoints.logout);
  }

  Future<void> forgotPassword(String email) async {
    await _client.post<void>(
      ApiEndpoints.forgotPassword,
      data: {'email': email},
    );
  }

  Future<AuthResponseDto> verifyOtp(String code) async {
    final response = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.verifyOtp,
      data: {'code': code},
    );
    return AuthResponseDto.fromJson(ApiResponseParser.asMap(response.data));
  }

  Future<void> resetPassword({
    required String email,
    required String password,
    String? token,
  }) async {
    await _client.post<void>(
      ApiEndpoints.resetPassword,
      data: {'email': email, 'password': password, 'token': ?token},
    );
  }

  // ── Dashboard ───────────────────────────────────────────────────────────────

  Future<DashboardDto> getDashboard() async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.dashboard,
    );
    return DashboardDto.fromJson(ApiResponseParser.asMap(response.data));
  }

  Future<AnalyticsDto> getAnalytics() async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.analytics,
    );
    return AnalyticsDto.fromJson(ApiResponseParser.asMap(response.data));
  }

  // ── Accounts ────────────────────────────────────────────────────────────────

  Future<AccountDto> getAccountById(String id) async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.accountById(id),
    );
    return AccountDto.fromJson(ApiResponseParser.asMap(response.data));
  }

  // ── Transactions ──────────────────────────────────────────────────────────────

  Future<List<TransactionDto>> getTransactions({String? type}) async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.transactions,
      queryParameters: type != null ? {'type': type} : null,
    );
    return ApiResponseParser.asList(
      response.data,
    ).map(TransactionDto.fromJson).toList();
  }

  Future<TransactionDto> getTransactionById(String id) async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.transactionById(id),
    );
    return TransactionDto.fromJson(ApiResponseParser.asMap(response.data));
  }

  // ── Transfer ────────────────────────────────────────────────────────────────

  Future<List<AccountDto>> getTransferAccounts() async {
    final response = await _client.get<dynamic>(ApiEndpoints.transfers);
    return ApiResponseParser.asList(
      response.data,
    ).map(AccountDto.fromJson).toList();
  }

  Future<List<BeneficiaryDto>> getBeneficiaries() async {
    final response = await _client.get<dynamic>(ApiEndpoints.beneficiaries);
    return ApiResponseParser.asList(
      response.data,
    ).map(BeneficiaryDto.fromJson).toList();
  }

  Future<void> submitTransfer(TransferRequestDto request) async {
    await _client.post<void>(ApiEndpoints.transfers, data: request.toJson());
  }

  Future<BeneficiaryDto> addBeneficiary({
    required String name,
    required String bankName,
    required String accountNumber,
  }) async {
    final response = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.beneficiaries,
      data: {
        'name': name,
        'bank_name': bankName,
        'account_number': accountNumber,
      },
    );
    return BeneficiaryDto.fromJson(ApiResponseParser.asMap(response.data));
  }

  // ── Cards ───────────────────────────────────────────────────────────────────

  Future<List<CardDto>> getCards() async {
    final response = await _client.get<dynamic>(ApiEndpoints.cards);
    return ApiResponseParser.asList(
      response.data,
    ).map(CardDto.fromJson).toList();
  }

  Future<CardDto> getCardById(String id) async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.cardById(id),
    );
    return CardDto.fromJson(ApiResponseParser.asMap(response.data));
  }

  Future<CardDto> toggleCardFreeze(String id) async {
    final response = await _client.patch<Map<String, dynamic>>(
      ApiEndpoints.freezeCard(id),
    );
    return CardDto.fromJson(ApiResponseParser.asMap(response.data));
  }

  // ── Payments ──────────────────────────────────────────────────────────────────

  Future<QrPaymentDto> getQrPayment() async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.qrPayment,
    );
    return QrPaymentDto.fromJson(ApiResponseParser.asMap(response.data));
  }

  Future<void> submitBillPayment(BillPaymentRequestDto request) async {
    await _client.post<void>(ApiEndpoints.billPayment, data: request.toJson());
  }

  // ── Notifications ─────────────────────────────────────────────────────────────

  Future<List<NotificationDto>> getNotifications() async {
    final response = await _client.get<dynamic>(ApiEndpoints.notifications);
    return ApiResponseParser.asList(
      response.data,
    ).map(NotificationDto.fromJson).toList();
  }

  Future<void> markNotificationRead(int index) async {
    await _client.patch<void>(ApiEndpoints.markNotificationRead(index));
  }

  // ── Profile ───────────────────────────────────────────────────────────────────

  Future<ProfileDto> getProfile() async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.profile,
    );
    return ProfileDto.fromJson(ApiResponseParser.asMap(response.data));
  }

  // ── Settings ──────────────────────────────────────────────────────────────────

  Future<SettingsDto> getSettings() async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.settings,
    );
    return SettingsDto.fromJson(ApiResponseParser.asMap(response.data));
  }

  Future<void> updateSettings(SettingsDto settings) async {
    await _client.put<void>(ApiEndpoints.settings, data: settings.toJson());
  }
}

/// Plain Dio client for token refresh (avoids interceptor recursion).
class AuthRefreshClient {
  AuthRefreshClient({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: ApiEndpoints.baseUrl,
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            ),
          );

  final Dio _dio;

  Future<AuthTokensDto> refresh(String refreshToken) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.refreshToken,
      data: {'refresh_token': refreshToken},
    );
    return AuthTokensDto.fromJson(ApiResponseParser.asMap(response.data));
  }
}
