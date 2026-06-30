import '../../../../core/utils/result.dart';
import '../../../../shared/domain/entities/account.dart';
import '../../../../shared/domain/entities/beneficiary.dart';

abstract class TransferRepository {
  ResultFuture<List<BankAccount>> getAccounts();
  ResultFuture<List<Beneficiary>> getBeneficiaries();
  ResultFuture<void> transfer({
    required String fromAccountId,
    required String beneficiaryId,
    required double amount,
    String? note,
  });
  ResultFuture<void> addBeneficiary({
    required String name,
    required String bankName,
    required String accountNumber,
  });
}
