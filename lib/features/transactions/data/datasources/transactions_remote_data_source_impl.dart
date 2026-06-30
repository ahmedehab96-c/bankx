import '../../../../core/network/dio_exception_helper.dart';
import '../../../../core/storage/cache_storage_service.dart';
import '../../../../shared/data/api/banking_api_service.dart';
import '../../../../shared/data/mappers/banking_mappers.dart';
import '../../../../shared/domain/entities/transaction.dart';
import 'transactions_remote_data_source.dart';

class TransactionsRemoteDataSourceImpl implements TransactionsRemoteDataSource {
  TransactionsRemoteDataSourceImpl(this._api, this._cache);

  final BankingApiService _api;
  final CacheStorageService _cache;

  @override
  Future<List<Transaction>> fetchTransactions({TransactionType? type}) async {
    try {
      final dtos = await _api.getTransactions(
        type: type?.name,
      );
      await _cache.writeList(
        CacheKeys.transactions,
        dtos.map((e) => e.toJson()).toList(),
      );
      return dtos.map(BankingMappers.toTransaction).toList();
    } catch (e) {
      rethrowAsAppException(e);
    }
  }

  @override
  Future<Transaction> fetchTransactionById(String id) async {
    try {
      final dto = await _api.getTransactionById(id);
      await _cache.write(CacheKeys.transaction(id), dto.toJson());
      return BankingMappers.toTransaction(dto);
    } catch (e) {
      rethrowAsAppException(e);
    }
  }
}
