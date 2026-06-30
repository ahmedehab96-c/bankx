import '../../../../core/network/dio_exception_helper.dart';
import '../../../../core/storage/cache_storage_service.dart';
import '../../../../shared/data/api/banking_api_service.dart';
import '../../../../shared/data/mappers/banking_mappers.dart';
import '../../../../shared/domain/entities/account.dart';
import 'accounts_remote_data_source.dart';

class AccountsRemoteDataSourceImpl implements AccountsRemoteDataSource {
  AccountsRemoteDataSourceImpl(this._api, this._cache);

  final BankingApiService _api;
  final CacheStorageService _cache;

  @override
  Future<BankAccount> fetchAccountById(String id) async {
    try {
      final dto = await _api.getAccountById(id);
      await _cache.write(CacheKeys.account(id), dto.toJson());
      return BankingMappers.toAccount(dto);
    } catch (e) {
      rethrowAsAppException(e);
    }
  }
}
