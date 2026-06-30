import '../../../../core/utils/result.dart';
import '../usecases/profile_usecases.dart';

abstract class ProfileRepository {
  ResultFuture<ProfileData> getProfileData();
}
