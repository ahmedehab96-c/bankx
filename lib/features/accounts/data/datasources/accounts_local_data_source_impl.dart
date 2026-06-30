import '../../../../core/storage/cache_storage_service.dart';
import '../../../../shared/data/dto/banking_dtos.dart';
import '../../../../shared/data/mappers/banking_mappers.dart';
import '../../../../shared/domain/entities/account.dart';
import 'accounts_local_data_source.dart';

class AccountsLocalDataSourceImpl implements AccountsLocalDataSource {
  AccountsLocalDataSourceImpl(this._cache);

  final CacheStorageService _cache;

  @override
  Future<BankAccount?> getCachedAccountById(String id) async {
    final json = await _cache.read(CacheKeys.account(id));
    if (json == null) return null;
    return BankingMappers.toAccount(AccountDto.fromJson(json));
  }
}
