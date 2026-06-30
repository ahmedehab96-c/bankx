import '../../../../core/network/network_bound_resource.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/result.dart';
import '../../../../shared/domain/entities/account.dart';
import '../../domain/repositories/accounts_repository.dart';
import '../datasources/accounts_local_data_source.dart';
import '../datasources/accounts_remote_data_source.dart';

class AccountsRepositoryImpl implements AccountsRepository {
  AccountsRepositoryImpl({
    required AccountsLocalDataSource local,
    required AccountsRemoteDataSource remote,
    required NetworkInfo networkInfo,
  }) : _local = local,
       _remote = remote,
       _networkInfo = networkInfo;

  final AccountsLocalDataSource _local;
  final AccountsRemoteDataSource _remote;
  final NetworkInfo _networkInfo;

  @override
  ResultFuture<BankAccount> getAccountById(String id) => NetworkBoundResource(
    networkInfo: _networkInfo,
    fetchRemote: () => _remote.fetchAccountById(id),
    fetchLocal: () => _local.getCachedAccountById(id),
    saveLocal: (_) async {},
  ).execute();
}
