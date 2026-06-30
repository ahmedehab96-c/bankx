import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../features/transfer/data/datasources/transfer_remote_data_source.dart';
import '../network/connectivity_service.dart';
import '../network/network_info.dart';
import '../storage/cache_storage_service.dart';

/// Syncs queued offline transfers when connectivity is restored.
class OfflineSyncService {
  OfflineSyncService({
    required CacheStorageService cache,
    required TransferRemoteDataSource transferRemote,
    required NetworkInfo networkInfo,
    ConnectivityService? connectivity,
  })  : _cache = cache,
        _transferRemote = transferRemote,
        _networkInfo = networkInfo,
        _connectivity = connectivity ?? ConnectivityService();

  final CacheStorageService _cache;
  final TransferRemoteDataSource _transferRemote;
  final NetworkInfo _networkInfo;
  final ConnectivityService _connectivity;

  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _syncing = false;

  void start() {
    _subscription?.cancel();
    _subscription = _connectivity.onConnectivityChanged.listen((_) {
      unawaited(syncPendingTransfers());
    });
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
    _subscription = null;
  }

  Future<int> syncPendingTransfers() async {
    if (_syncing || !await _networkInfo.isConnected) return 0;
    _syncing = true;
    var synced = 0;
    try {
      final pending = await _cache.pendingTransfers();
      for (final item in pending) {
        try {
          await _transferRemote.submitTransfer(
            fromAccountId: item['fromAccountId'] as String,
            beneficiaryId: item['beneficiaryId'] as String,
            amount: (item['amount'] as num).toDouble(),
            note: item['note'] as String?,
          );
          await _cache.removeQueuedTransfer(item['id'] as String);
          synced++;
        } catch (_) {
          break;
        }
      }
    } finally {
      _syncing = false;
    }
    return synced;
  }
}
