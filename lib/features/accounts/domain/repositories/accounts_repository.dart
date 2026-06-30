import '../../../../core/utils/result.dart';
import '../../../../shared/domain/entities/account.dart';

abstract class AccountsRepository {
  ResultFuture<BankAccount> getAccountById(String id);
}
