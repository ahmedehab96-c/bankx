import '../../domain/usecases/profile_usecases.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileData> fetchProfileData();
}
