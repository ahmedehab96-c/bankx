import '../../../../core/storage/cache_storage_service.dart';
import '../../../../shared/data/dto/banking_dtos.dart';
import '../../../../shared/data/mappers/banking_mappers.dart';
import '../../../../shared/domain/entities/transaction.dart';
import 'transactions_local_data_source.dart';

class TransactionsLocalDataSourceImpl implements TransactionsLocalDataSource {
  TransactionsLocalDataSourceImpl(this._cache);

  final CacheStorageService _cache;

  @override
  Future<List<Transaction>?> getCachedTransactions() async {
    final items = await _cache.readList(CacheKeys.transactions);
    if (items == null) return null;
    return items
        .map((e) => BankingMappers.toTransaction(TransactionDto.fromJson(e)))
        .toList();
  }

  @override
  Future<Transaction?> getCachedTransactionById(String id) async {
    final json = await _cache.read(CacheKeys.transaction(id));
    if (json == null) return null;
    return BankingMappers.toTransaction(TransactionDto.fromJson(json));
  }
}
