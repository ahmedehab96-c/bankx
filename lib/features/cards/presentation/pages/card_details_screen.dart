import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/widgets/app_screen_scaffold.dart';
import '../../../../core/widgets/banking_card.dart';
import '../../../../core/widgets/detail_info_tile.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../../../shared/domain/entities/card_model.dart';
import '../bloc/cards_bloc.dart';
import '../bloc/cards_state.dart';

/// Detailed card view with actions.
class CardDetailsScreen extends StatelessWidget {
  const CardDetailsScreen({super.key, required this.cardId});

  final String cardId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<CardsBloc, CardsState>(
      builder: (context, state) {
        if (state.detailsStatus == RequestStatus.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final card = state.selectedCard;
        if (card == null) {
          return NotFoundBody(
            message: state.errorMessage ?? 'Card not found',
          );
        }

        return AppScreenScaffold.scroll(
          title: l10n.cardDetails,
          body: Column(
            children: [
              BankingCard(
                title: card.holderName,
                subtitle: card.cardNumber,
                balance: card.balance,
                currency: card.currency,
                gradientColors: card.gradientColors.map(Color.new).toList(),
              ),
              const SizedBox(height: 28),
              DetailInfoTile(label: l10n.cardHolder, value: card.holderName),
              DetailInfoTile(label: l10n.cardNumber, value: card.cardNumber),
              DetailInfoTile(label: l10n.expiryDate, value: card.expiryDate),
              DetailInfoTile(label: l10n.cvv, value: card.cvv),
              DetailInfoTile(
                label: l10n.status,
                value:
                    card.status == CardStatus.active ? l10n.active : l10n.frozen,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => context.pushFreezeCard(cardId),
                  icon: Icon(
                    card.status == CardStatus.frozen
                        ? Icons.lock_open_rounded
                        : Icons.ac_unit_rounded,
                  ),
                  label: Text(
                    card.status == CardStatus.frozen
                        ? l10n.unfreezeCard
                        : l10n.freezeCard,
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
