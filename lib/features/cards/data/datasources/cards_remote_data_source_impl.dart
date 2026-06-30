import '../../../../core/network/dio_exception_helper.dart';
import '../../../../core/storage/cache_storage_service.dart';
import '../../../../shared/data/api/banking_api_service.dart';
import '../../../../shared/data/mappers/banking_mappers.dart';
import '../../../../shared/domain/entities/card_model.dart';
import 'cards_remote_data_source.dart';

class CardsRemoteDataSourceImpl implements CardsRemoteDataSource {
  CardsRemoteDataSourceImpl(this._api, this._cache);

  final BankingApiService _api;
  final CacheStorageService _cache;

  @override
  Future<List<BankCard>> fetchCards() async {
    try {
      final dtos = await _api.getCards();
      await _cache.writeList(
        CacheKeys.cards,
        dtos.map((e) => e.toJson()).toList(),
      );
      return dtos.map(BankingMappers.toCard).toList();
    } catch (e) {
      rethrowAsAppException(e);
    }
  }

  @override
  Future<BankCard> fetchCardById(String id) async {
    try {
      final dto = await _api.getCardById(id);
      await _cache.write(CacheKeys.card(id), dto.toJson());
      return BankingMappers.toCard(dto);
    } catch (e) {
      rethrowAsAppException(e);
    }
  }

  @override
  Future<BankCard> toggleCardFreeze(String cardId) async {
    try {
      final dto = await _api.toggleCardFreeze(cardId);
      await _cache.write(CacheKeys.card(cardId), dto.toJson());
      return BankingMappers.toCard(dto);
    } catch (e) {
      rethrowAsAppException(e);
    }
  }
}
