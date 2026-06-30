import '../../../../shared/domain/entities/transaction.dart';

abstract class TransactionsRemoteDataSource {
  Future<List<Transaction>> fetchTransactions({TransactionType? type});
  Future<Transaction> fetchTransactionById(String id);
}
