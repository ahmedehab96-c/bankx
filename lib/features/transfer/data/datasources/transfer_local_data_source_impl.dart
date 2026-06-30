import '../../../../core/storage/cache_storage_service.dart';
import '../../../../shared/data/dto/banking_dtos.dart';
import '../../../../shared/data/mappers/banking_mappers.dart';
import '../../../../shared/domain/entities/account.dart';
import '../../../../shared/domain/entities/beneficiary.dart';
import 'transfer_local_data_source.dart';

class TransferLocalDataSourceImpl implements TransferLocalDataSource {
  TransferLocalDataSourceImpl(this._cache);

  final CacheStorageService _cache;

  @override
  Future<List<BankAccount>?> getCachedAccounts() async {
    final items = await _cache.readList(CacheKeys.accounts);
    if (items == null) return null;
    return items.map((e) => BankingMappers.toAccount(AccountDto.fromJson(e))).toList();
  }

  @override
  Future<List<Beneficiary>?> getCachedBeneficiaries() async {
    final items = await _cache.readList(CacheKeys.beneficiaries);
    if (items == null) return null;
    return items
        .map((e) => BankingMappers.toBeneficiary(BeneficiaryDto.fromJson(e)))
        .toList();
  }
}
