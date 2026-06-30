import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/usecase.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../domain/usecases/profile_usecases.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required GetProfileDataUseCase getProfileDataUseCase})
      : _getProfileDataUseCase = getProfileDataUseCase,
        super(const ProfileState()) {
    on<ProfileLoaded>(_onProfileLoaded);
  }

  final GetProfileDataUseCase _getProfileDataUseCase;

  Future<void> _onProfileLoaded(
    ProfileLoaded event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading, clearError: true));
    final result = await _getProfileDataUseCase(const NoParams());
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
          profileData: data,
        ),
      ),
    );
  }
}
