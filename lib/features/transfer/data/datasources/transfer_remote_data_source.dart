import '../../../../shared/domain/entities/account.dart';
import '../../../../shared/domain/entities/beneficiary.dart';

abstract class TransferRemoteDataSource {
  Future<List<BankAccount>> fetchAccounts();
  Future<List<Beneficiary>> fetchBeneficiaries();
  Future<void> submitTransfer({
    required String fromAccountId,
    required String beneficiaryId,
    required double amount,
    String? note,
  });
  Future<void> submitBeneficiary({
    required String name,
    required String bankName,
    required String accountNumber,
  });
}
