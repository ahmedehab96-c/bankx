import '../../../../core/network/dio_exception_helper.dart';
import '../../../../core/storage/cache_storage_service.dart';
import '../../../../shared/data/api/banking_api_service.dart';
import '../../../../shared/data/mappers/banking_mappers.dart';
import '../../domain/usecases/dashboard_usecases.dart';
import 'dashboard_remote_data_source.dart';

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  DashboardRemoteDataSourceImpl(this._api, this._cache);

  final BankingApiService _api;
  final CacheStorageService _cache;

  @override
  Future<DashboardData> fetchDashboardData() async {
    try {
      final dto = await _api.getDashboard();
      await _cache.write(CacheKeys.dashboard, dto.toJson());
      return BankingMappers.toDashboard(dto);
    } catch (e) {
      rethrowAsAppException(e);
    }
  }

  @override
  Future<AnalyticsData> fetchAnalyticsData() async {
    try {
      final dto = await _api.getAnalytics();
      await _cache.write(CacheKeys.analytics, dto.toJson());
      return BankingMappers.toAnalytics(dto);
    } catch (e) {
      rethrowAsAppException(e);
    }
  }
}
