import '../../domain/usecases/dashboard_usecases.dart';

/// Remote dashboard API contract.
abstract class DashboardRemoteDataSource {
  Future<DashboardData> fetchDashboardData();
  Future<AnalyticsData> fetchAnalyticsData();
}
