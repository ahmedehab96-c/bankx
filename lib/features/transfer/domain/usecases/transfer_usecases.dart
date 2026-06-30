import '../../../../core/utils/result.dart';
import '../../../../core/utils/usecase.dart';
import '../../../../shared/domain/entities/account.dart';
import '../../../../shared/domain/entities/beneficiary.dart';
import '../repositories/transfer_repository.dart';

class GetAccountsUseCase implements UseCase<List<BankAccount>, NoParams> {
  GetAccountsUseCase(this._repository);

  final TransferRepository _repository;

  @override
  ResultFuture<List<BankAccount>> call(NoParams params) =>
      _repository.getAccounts();
}

class GetTransferBeneficiariesUseCase
    implements UseCase<List<Beneficiary>, NoParams> {
  GetTransferBeneficiariesUseCase(this._repository);

  final TransferRepository _repository;

  @override
  ResultFuture<List<Beneficiary>> call(NoParams params) =>
      _repository.getBeneficiaries();
}

class TransferMoneyParams {
  const TransferMoneyParams({
    required this.fromAccountId,
    required this.beneficiaryId,
    required this.amount,
    this.note,
  });

  final String fromAccountId;
  final String beneficiaryId;
  final double amount;
  final String? note;
}

class TransferMoneyUseCase implements UseCase<void, TransferMoneyParams> {
  TransferMoneyUseCase(this._repository);

  final TransferRepository _repository;

  @override
  ResultFuture<void> call(TransferMoneyParams params) => _repository.transfer(
    fromAccountId: params.fromAccountId,
    beneficiaryId: params.beneficiaryId,
    amount: params.amount,
    note: params.note,
  );
}

class AddBeneficiaryParams {
  const AddBeneficiaryParams({
    required this.name,
    required this.bankName,
    required this.accountNumber,
  });

  final String name;
  final String bankName;
  final String accountNumber;
}

class AddBeneficiaryUseCase implements UseCase<void, AddBeneficiaryParams> {
  AddBeneficiaryUseCase(this._repository);

  final TransferRepository _repository;

  @override
  ResultFuture<void> call(AddBeneficiaryParams params) =>
      _repository.addBeneficiary(
        name: params.name,
        bankName: params.bankName,
        accountNumber: params.accountNumber,
      );
}
