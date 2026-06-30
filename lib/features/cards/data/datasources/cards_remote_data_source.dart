import '../../../../shared/domain/entities/card_model.dart';

abstract class CardsRemoteDataSource {
  Future<List<BankCard>> fetchCards();
  Future<BankCard> fetchCardById(String id);
  Future<BankCard> toggleCardFreeze(String cardId);
}
