import '../../../../core/storage/cache_storage_service.dart';
import '../../../../shared/data/dto/banking_dtos.dart';
import '../../../../shared/data/mappers/banking_mappers.dart';
import '../../domain/usecases/profile_usecases.dart';
import 'profile_local_data_source.dart';

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  ProfileLocalDataSourceImpl(this._cache);

  final CacheStorageService _cache;

  @override
  Future<ProfileData?> getCachedProfileData() async {
    final json = await _cache.read(CacheKeys.profile);
    if (json == null) return null;
    return BankingMappers.toProfile(ProfileDto.fromJson(json));
  }
}
