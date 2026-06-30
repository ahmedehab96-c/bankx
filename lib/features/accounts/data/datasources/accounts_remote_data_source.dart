import '../../../../shared/domain/entities/account.dart';

abstract class AccountsRemoteDataSource {
  Future<BankAccount> fetchAccountById(String id);
}
