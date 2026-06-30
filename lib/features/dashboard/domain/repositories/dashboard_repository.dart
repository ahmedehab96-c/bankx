import '../../../../core/utils/result.dart';
import '../usecases/dashboard_usecases.dart';

abstract class DashboardRepository {
  ResultFuture<DashboardData> getDashboardData();
  ResultFuture<AnalyticsData> getAnalyticsData();
}
