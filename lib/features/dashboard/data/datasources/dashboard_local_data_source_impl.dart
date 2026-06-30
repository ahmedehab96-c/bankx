import '../../../../core/storage/cache_storage_service.dart';
import '../../../../shared/data/dto/banking_dtos.dart';
import '../../../../shared/data/mappers/banking_mappers.dart';
import '../../domain/usecases/dashboard_usecases.dart';
import 'dashboard_local_data_source.dart';

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  DashboardLocalDataSourceImpl(this._cache);

  final CacheStorageService _cache;

  @override
  Future<DashboardData?> getCachedDashboardData() async {
    final json = await _cache.read(CacheKeys.dashboard);
    if (json == null) return null;
    return BankingMappers.toDashboard(DashboardDto.fromJson(json));
  }

  @override
  Future<AnalyticsData?> getCachedAnalyticsData() async {
    final json = await _cache.read(CacheKeys.analytics);
    if (json == null) return null;
    return BankingMappers.toAnalytics(AnalyticsDto.fromJson(json));
  }
}
