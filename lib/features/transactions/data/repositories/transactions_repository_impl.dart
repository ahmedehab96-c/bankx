import '../../../../core/network/network_bound_resource.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/result.dart';
import '../../../../shared/domain/entities/transaction.dart';
import '../../domain/repositories/transactions_repository.dart';
import '../datasources/transactions_local_data_source.dart';
import '../datasources/transactions_remote_data_source.dart';

class TransactionsRepositoryImpl implements TransactionsRepository {
  TransactionsRepositoryImpl({
    required TransactionsLocalDataSource local,
    required TransactionsRemoteDataSource remote,
    required NetworkInfo networkInfo,
  }) : _local = local,
       _remote = remote,
       _networkInfo = networkInfo;

  final TransactionsLocalDataSource _local;
  final TransactionsRemoteDataSource _remote;
  final NetworkInfo _networkInfo;

  @override
  ResultFuture<List<Transaction>> getTransactions({TransactionType? type}) {
    return NetworkBoundResource(
      networkInfo: _networkInfo,
      fetchRemote: () => _remote.fetchTransactions(type: type),
      fetchLocal: () async {
        final cached = await _local.getCachedTransactions();
        if (cached == null || type == null) return cached;
        return cached.where((t) => t.type == type).toList();
      },
      saveLocal: (_) async {},
    ).execute();
  }

  @override
  ResultFuture<Transaction> getTransactionById(String id) =>
      NetworkBoundResource(
        networkInfo: _networkInfo,
        fetchRemote: () => _remote.fetchTransactionById(id),
        fetchLocal: () => _local.getCachedTransactionById(id),
        saveLocal: (_) async {},
      ).execute();
}
