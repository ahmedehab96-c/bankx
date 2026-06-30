import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'connectivity_service.dart';

/// Contract for checking real internet connectivity.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Production [NetworkInfo] using connectivity + internet checker.
class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this._connectivityService);

  final ConnectivityService _connectivityService;

  @override
  Future<bool> get isConnected async {
    if (!await _connectivityService.hasNetworkInterface()) return false;
    return _connectivityService.hasInternetAccess();
  }
}

/// Caches connectivity results and listens to network changes to avoid
/// duplicate async checks on every repository call.
class CachingNetworkInfo implements NetworkInfo {
  CachingNetworkInfo(
    this._delegate, {
    ConnectivityService? connectivity,
    Duration cacheTtl = const Duration(seconds: 3),
  }) : _connectivity = connectivity ?? ConnectivityService(),
       _cacheTtl = cacheTtl {
    _subscription = _connectivity.onConnectivityChanged.listen((_) {
      _cachedConnected = null;
      _cacheExpiresAt = null;
    });
  }

  final NetworkInfo _delegate;
  final ConnectivityService _connectivity;
  final Duration _cacheTtl;

  bool? _cachedConnected;
  DateTime? _cacheExpiresAt;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  @override
  Future<bool> get isConnected async {
    final now = DateTime.now();
    if (_cachedConnected != null &&
        _cacheExpiresAt != null &&
        now.isBefore(_cacheExpiresAt!)) {
      return _cachedConnected!;
    }

    final connected = await _delegate.isConnected;
    _cachedConnected = connected;
    _cacheExpiresAt = now.add(_cacheTtl);
    return connected;
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
    _subscription = null;
  }
}
