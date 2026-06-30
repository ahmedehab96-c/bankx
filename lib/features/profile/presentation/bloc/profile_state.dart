import 'package:equatable/equatable.dart';

import '../../../../shared/bloc/request_status.dart';
import '../../domain/usecases/profile_usecases.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.status = RequestStatus.initial,
    this.profileData,
    this.errorMessage,
  });

  final RequestStatus status;
  final ProfileData? profileData;
  final String? errorMessage;

  ProfileState copyWith({
    RequestStatus? status,
    ProfileData? profileData,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profileData: profileData ?? this.profileData,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, profileData, errorMessage];
}
