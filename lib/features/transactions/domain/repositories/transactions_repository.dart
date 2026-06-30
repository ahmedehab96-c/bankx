import '../../../../core/utils/result.dart';
import '../../../../shared/domain/entities/transaction.dart';

abstract class TransactionsRepository {
  ResultFuture<List<Transaction>> getTransactions({TransactionType? type});
  ResultFuture<Transaction> getTransactionById(String id);
}
