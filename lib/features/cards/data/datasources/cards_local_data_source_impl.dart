import '../../../../core/storage/cache_storage_service.dart';
import '../../../../shared/data/dto/banking_dtos.dart';
import '../../../../shared/data/mappers/banking_mappers.dart';
import '../../../../shared/domain/entities/card_model.dart';
import 'cards_local_data_source.dart';

class CardsLocalDataSourceImpl implements CardsLocalDataSource {
  CardsLocalDataSourceImpl(this._cache);

  final CacheStorageService _cache;

  @override
  Future<List<BankCard>?> getCachedCards() async {
    final items = await _cache.readList(CacheKeys.cards);
    if (items == null) return null;
    return items
        .map((e) => BankingMappers.toCard(CardDto.fromJson(e)))
        .toList();
  }

  @override
  Future<BankCard?> getCachedCardById(String id) async {
    final json = await _cache.read(CacheKeys.card(id));
    if (json == null) return null;
    return BankingMappers.toCard(CardDto.fromJson(json));
  }
}
