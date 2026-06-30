import '../../../../core/network/network_bound_resource.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/result.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/usecases/profile_usecases.dart';
import '../datasources/profile_local_data_source.dart';
import '../datasources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({
    required ProfileLocalDataSource local,
    required ProfileRemoteDataSource remote,
    required NetworkInfo networkInfo,
  }) : _local = local,
       _remote = remote,
       _networkInfo = networkInfo;

  final ProfileLocalDataSource _local;
  final ProfileRemoteDataSource _remote;
  final NetworkInfo _networkInfo;

  @override
  ResultFuture<ProfileData> getProfileData() => NetworkBoundResource(
    networkInfo: _networkInfo,
    fetchRemote: _remote.fetchProfileData,
    fetchLocal: _local.getCachedProfileData,
    saveLocal: (_) async {},
  ).execute();
}
