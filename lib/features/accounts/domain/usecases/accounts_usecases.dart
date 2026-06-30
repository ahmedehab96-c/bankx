import '../../../../core/utils/result.dart';
import '../../../../core/utils/usecase.dart';
import '../../../../shared/domain/entities/account.dart';
import '../repositories/accounts_repository.dart';

class GetAccountByIdParams {
  const GetAccountByIdParams(this.id);

  final String id;
}

class GetAccountByIdUseCase
    implements UseCase<BankAccount, GetAccountByIdParams> {
  GetAccountByIdUseCase(this._repository);

  final AccountsRepository _repository;

  @override
  ResultFuture<BankAccount> call(GetAccountByIdParams params) =>
      _repository.getAccountById(params.id);
}
