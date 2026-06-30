import 'package:equatable/equatable.dart';

import '../../../../shared/bloc/request_status.dart';
import '../../domain/usecases/dashboard_usecases.dart';

class DashboardState extends Equatable {
  const DashboardState({
    this.status = RequestStatus.initial,
    this.analyticsStatus = RequestStatus.initial,
    this.dashboardData,
    this.analyticsData,
    this.errorMessage,
  });

  final RequestStatus status;
  final RequestStatus analyticsStatus;
  final DashboardData? dashboardData;
  final AnalyticsData? analyticsData;
  final String? errorMessage;

  DashboardState copyWith({
    RequestStatus? status,
    RequestStatus? analyticsStatus,
    DashboardData? dashboardData,
    AnalyticsData? analyticsData,
    String? errorMessage,
    bool clearError = false,
  }) {
    return DashboardState(
      status: status ?? this.status,
      analyticsStatus: analyticsStatus ?? this.analyticsStatus,
      dashboardData: dashboardData ?? this.dashboardData,
      analyticsData: analyticsData ?? this.analyticsData,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    analyticsStatus,
    dashboardData,
    analyticsData,
    errorMessage,
  ];
}
