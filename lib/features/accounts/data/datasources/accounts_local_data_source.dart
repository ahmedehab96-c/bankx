import '../../../../shared/domain/entities/account.dart';

abstract class AccountsLocalDataSource {
  Future<BankAccount?> getCachedAccountById(String id);
}
