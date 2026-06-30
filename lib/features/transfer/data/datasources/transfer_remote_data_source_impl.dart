import '../../../../core/network/dio_exception_helper.dart';
import '../../../../core/storage/cache_storage_service.dart';
import '../../../../shared/data/api/banking_api_service.dart';
import '../../../../shared/data/dto/banking_dtos.dart';
import '../../../../shared/data/mappers/banking_mappers.dart';
import '../../../../shared/domain/entities/account.dart';
import '../../../../shared/domain/entities/beneficiary.dart';
import 'transfer_remote_data_source.dart';

class TransferRemoteDataSourceImpl implements TransferRemoteDataSource {
  TransferRemoteDataSourceImpl(this._api, this._cache);

  final BankingApiService _api;
  final CacheStorageService _cache;

  @override
  Future<List<BankAccount>> fetchAccounts() async {
    try {
      final dtos = await _api.getTransferAccounts();
      await _cache.writeList(
        CacheKeys.accounts,
        dtos.map((e) => e.toJson()).toList(),
      );
      return dtos.map(BankingMappers.toAccount).toList();
    } catch (e) {
      rethrowAsAppException(e);
    }
  }

  @override
  Future<List<Beneficiary>> fetchBeneficiaries() async {
    try {
      final dtos = await _api.getBeneficiaries();
      await _cache.writeList(
        CacheKeys.beneficiaries,
        dtos.map((e) => e.toJson()).toList(),
      );
      return dtos.map(BankingMappers.toBeneficiary).toList();
    } catch (e) {
      rethrowAsAppException(e);
    }
  }

  @override
  Future<void> submitTransfer({
    required String fromAccountId,
    required String beneficiaryId,
    required double amount,
    String? note,
  }) async {
    try {
      await _api.submitTransfer(
        TransferRequestDto(
          fromAccountId: fromAccountId,
          beneficiaryId: beneficiaryId,
          amount: amount,
          note: note,
        ),
      );
    } catch (e) {
      rethrowAsAppException(e);
    }
  }

  @override
  Future<void> submitBeneficiary({
    required String name,
    required String bankName,
    required String accountNumber,
  }) async {
    try {
      await _api.addBeneficiary(
        name: name,
        bankName: bankName,
        accountNumber: accountNumber,
      );
    } catch (e) {
      rethrowAsAppException(e);
    }
  }
}
