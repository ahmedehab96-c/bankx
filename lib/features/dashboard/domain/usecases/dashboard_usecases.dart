import '../../../../core/utils/result.dart';
import '../../../../core/utils/usecase.dart';
import '../../../../shared/domain/entities/account.dart';
import '../../../../shared/domain/entities/transaction.dart';
import '../../../../shared/domain/entities/user.dart';
import '../repositories/dashboard_repository.dart';

class DashboardData {
  const DashboardData({
    required this.user,
    required this.totalBalance,
    required this.accounts,
    required this.recentTransactions,
    required this.weeklySpending,
    required this.weeklyLabels,
  });

  final UserProfile user;
  final double totalBalance;
  final List<BankAccount> accounts;
  final List<Transaction> recentTransactions;
  final List<double> weeklySpending;
  final List<String> weeklyLabels;
}

class AnalyticsData {
  const AnalyticsData({
    required this.weeklySpending,
    required this.weeklyLabels,
    required this.totalIncome,
    required this.totalExpense,
  });

  final List<double> weeklySpending;
  final List<String> weeklyLabels;
  final double totalIncome;
  final double totalExpense;
}

class GetDashboardDataUseCase implements UseCase<DashboardData, NoParams> {
  GetDashboardDataUseCase(this._repository);

  final DashboardRepository _repository;

  @override
  ResultFuture<DashboardData> call(NoParams params) =>
      _repository.getDashboardData();
}

class GetAnalyticsDataUseCase implements UseCase<AnalyticsData, NoParams> {
  GetAnalyticsDataUseCase(this._repository);

  final DashboardRepository _repository;

  @override
  ResultFuture<AnalyticsData> call(NoParams params) =>
      _repository.getAnalyticsData();
}
