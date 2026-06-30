import '../../domain/usecases/dashboard_usecases.dart';

/// Local dashboard cache contract.
abstract class DashboardLocalDataSource {
  Future<DashboardData?> getCachedDashboardData();
  Future<AnalyticsData?> getCachedAnalyticsData();
}
