import '../../../../core/utils/result.dart';
import '../../../../core/utils/usecase.dart';
import '../../../../shared/domain/entities/user.dart';
import '../repositories/profile_repository.dart';

class ProfileData {
  const ProfileData({required this.user, required this.cardCount});

  final UserProfile user;
  final int cardCount;
}

class GetProfileDataUseCase implements UseCase<ProfileData, NoParams> {
  GetProfileDataUseCase(this._repository);

  final ProfileRepository _repository;

  @override
  ResultFuture<ProfileData> call(NoParams params) =>
      _repository.getProfileData();
}
