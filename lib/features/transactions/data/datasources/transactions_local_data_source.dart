import '../../../../shared/domain/entities/transaction.dart';

abstract class TransactionsLocalDataSource {
  Future<List<Transaction>?> getCachedTransactions();
  Future<Transaction?> getCachedTransactionById(String id);
}
