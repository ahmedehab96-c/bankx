import '../../../../core/utils/result.dart';
import '../../../../shared/domain/entities/card_model.dart';

abstract class CardsRepository {
  ResultFuture<List<BankCard>> getCards();
  ResultFuture<BankCard> getCardById(String id);
  ResultFuture<BankCard> toggleCardFreeze(String cardId);
}
