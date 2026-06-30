import 'package:dartz/dartz.dart';

import 'package:uuid/uuid.dart';

import '../../../../core/network/network_bound_resource.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/offline/offline_sync_service.dart';
import '../../../../core/storage/cache_storage_service.dart';
import '../../../../core/utils/result.dart';
import '../../../../shared/domain/entities/account.dart';
import '../../../../shared/domain/entities/beneficiary.dart';
import '../../domain/repositories/transfer_repository.dart';
import '../datasources/transfer_local_data_source.dart';
import '../datasources/transfer_remote_data_source.dart';

class TransferRepositoryImpl implements TransferRepository {
  TransferRepositoryImpl({
    required TransferLocalDataSource local,
    required TransferRemoteDataSource remote,
    required NetworkInfo networkInfo,
    required CacheStorageService cache,
    OfflineSyncService? offlineSync,
  })  : _local = local,
        _remote = remote,
        _networkInfo = networkInfo,
        _cache = cache,
        _offlineSync = offlineSync,
        _remoteResource = RemoteResource(networkInfo: networkInfo);

  final TransferLocalDataSource _local;
  final TransferRemoteDataSource _remote;
  final NetworkInfo _networkInfo;
  final CacheStorageService _cache;
  final OfflineSyncService? _offlineSync;
  final RemoteResource _remoteResource;

  @override
  ResultFuture<List<BankAccount>> getAccounts() => NetworkBoundResource(
        networkInfo: _networkInfo,
        fetchRemote: _remote.fetchAccounts,
        fetchLocal: _local.getCachedAccounts,
        saveLocal: (_) async {},
      ).execute();

  @override
  ResultFuture<List<Beneficiary>> getBeneficiaries() =>
      NetworkBoundResource(
        networkInfo: _networkInfo,
        fetchRemote: _remote.fetchBeneficiaries,
        fetchLocal: _local.getCachedBeneficiaries,
        saveLocal: (_) async {},
      ).execute();

  @override
  ResultFuture<void> transfer({
    required String fromAccountId,
    required String beneficiaryId,
    required double amount,
    String? note,
  }) async {
    if (!await _networkInfo.isConnected) {
      final id = const Uuid().v4();
      await _cache.enqueueTransfer({
        'id': id,
        'fromAccountId': fromAccountId,
        'beneficiaryId': beneficiaryId,
        'amount': amount,
        'note': note,
        'createdAt': DateTime.now().toIso8601String(),
      });
      return const Right(null);
    }
    final result = await _remoteResource.executeVoid(
      () => _remote.submitTransfer(
        fromAccountId: fromAccountId,
        beneficiaryId: beneficiaryId,
        amount: amount,
        note: note,
      ),
    );
    await _offlineSync?.syncPendingTransfers();
    return result;
  }

  @override
  ResultFuture<void> addBeneficiary({
    required String name,
    required String bankName,
    required String accountNumber,
  }) =>
      _remoteResource.executeVoid(
        () async {
          await _remote.submitBeneficiary(
            name: name,
            bankName: bankName,
            accountNumber: accountNumber,
          );
        },
      );
}
