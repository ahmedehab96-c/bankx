import '../../../../core/network/network_bound_resource.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/result.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/usecases/dashboard_usecases.dart';
import '../datasources/dashboard_local_data_source.dart';
import '../datasources/dashboard_remote_data_source.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl({
    required DashboardLocalDataSource local,
    required DashboardRemoteDataSource remote,
    required NetworkInfo networkInfo,
  })  : _local = local,
        _remote = remote,
        _networkInfo = networkInfo;

  final DashboardLocalDataSource _local;
  final DashboardRemoteDataSource _remote;
  final NetworkInfo _networkInfo;

  @override
  ResultFuture<DashboardData> getDashboardData() => NetworkBoundResource(
        networkInfo: _networkInfo,
        fetchRemote: _remote.fetchDashboardData,
        fetchLocal: _local.getCachedDashboardData,
        saveLocal: (_) async {},
      ).execute();

  @override
  ResultFuture<AnalyticsData> getAnalyticsData() => NetworkBoundResource(
        networkInfo: _networkInfo,
        fetchRemote: _remote.fetchAnalyticsData,
        fetchLocal: _local.getCachedAnalyticsData,
        saveLocal: (_) async {},
      ).execute();
}
