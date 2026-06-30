import '../../../../shared/domain/entities/card_model.dart';

abstract class CardsLocalDataSource {
  Future<List<BankCard>?> getCachedCards();
  Future<BankCard?> getCachedCardById(String id);
}
