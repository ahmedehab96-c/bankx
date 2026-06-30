import '../../../../core/utils/result.dart';
import '../../../../core/utils/usecase.dart';
import '../../../../shared/domain/entities/transaction.dart';
import '../repositories/transactions_repository.dart';

class GetTransactionsParams {
  const GetTransactionsParams({this.type});

  final TransactionType? type;
}

class GetTransactionsUseCase
    implements UseCase<List<Transaction>, GetTransactionsParams> {
  GetTransactionsUseCase(this._repository);

  final TransactionsRepository _repository;

  @override
  ResultFuture<List<Transaction>> call(GetTransactionsParams params) =>
      _repository.getTransactions(type: params.type);
}

class GetTransactionByIdParams {
  const GetTransactionByIdParams(this.id);

  final String id;
}

class GetTransactionByIdUseCase
    implements UseCase<Transaction, GetTransactionByIdParams> {
  GetTransactionByIdUseCase(this._repository);

  final TransactionsRepository _repository;

  @override
  ResultFuture<Transaction> call(GetTransactionByIdParams params) =>
      _repository.getTransactionById(params.id);
}
