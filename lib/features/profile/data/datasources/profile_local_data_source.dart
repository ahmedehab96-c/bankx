import '../../domain/usecases/profile_usecases.dart';

abstract class ProfileLocalDataSource {
  Future<ProfileData?> getCachedProfileData();
}
