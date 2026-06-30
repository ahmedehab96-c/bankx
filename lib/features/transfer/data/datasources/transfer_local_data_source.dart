import '../../../../shared/domain/entities/account.dart';
import '../../../../shared/domain/entities/beneficiary.dart';

abstract class TransferLocalDataSource {
  Future<List<BankAccount>?> getCachedAccounts();
  Future<List<Beneficiary>?> getCachedBeneficiaries();
}
