import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/usecase.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../domain/usecases/dashboard_usecases.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({
    required GetDashboardDataUseCase getDashboardDataUseCase,
    required GetAnalyticsDataUseCase getAnalyticsDataUseCase,
  })  : _getDashboardDataUseCase = getDashboardDataUseCase,
        _getAnalyticsDataUseCase = getAnalyticsDataUseCase,
        super(const DashboardState()) {
    on<DashboardLoaded>(_onDashboardLoaded);
    on<DashboardAnalyticsLoaded>(_onAnalyticsLoaded);
  }

  final GetDashboardDataUseCase _getDashboardDataUseCase;
  final GetAnalyticsDataUseCase _getAnalyticsDataUseCase;

  Future<void> _onDashboardLoaded(
    DashboardLoaded event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading, clearError: true));
    final result = await _getDashboardDataUseCase(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (data) => emit(
        state.copyWith(
          status: RequestStatus.success,
          dashboardData: data,
        ),
      ),
    );
  }

  Future<void> _onAnalyticsLoaded(
    DashboardAnalyticsLoaded event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(analyticsStatus: RequestStatus.loading, clearError: true));
    final result = await _getAnalyticsDataUseCase(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          analyticsStatus: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (data) => emit(
        state.copyWith(
          analyticsStatus: RequestStatus.success,
          analyticsData: data,
        ),
      ),
    );
  }
}
