import '../../../../core/network/dio_exception_helper.dart';
import '../../../../core/storage/cache_storage_service.dart';
import '../../../../shared/data/api/banking_api_service.dart';
import '../../../../shared/data/mappers/banking_mappers.dart';
import '../../domain/usecases/profile_usecases.dart';
import 'profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl(this._api, this._cache);

  final BankingApiService _api;
  final CacheStorageService _cache;

  @override
  Future<ProfileData> fetchProfileData() async {
    try {
      final dto = await _api.getProfile();
      await _cache.write(CacheKeys.profile, dto.toJson());
      return BankingMappers.toProfile(dto);
    } catch (e) {
      rethrowAsAppException(e);
    }
  }
}
