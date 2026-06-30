import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/performance/bloc_build_when.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/banking_card.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../../../shared/domain/entities/card_model.dart';
import '../bloc/cards_bloc.dart';
import '../bloc/cards_event.dart';
import '../bloc/cards_state.dart';

/// List of user's debit/credit cards.
class MyCardsScreen extends StatefulWidget {
  const MyCardsScreen({super.key});

  @override
  State<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  var _cardsRequested = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_cardsRequested) return;
    _cardsRequested = true;
    final bloc = context.read<CardsBloc>();
    if (bloc.state.listStatus == RequestStatus.initial) {
      bloc.add(const CardsLoaded());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final padding = Responsive.horizontalPadding(context);

    return BlocBuilder<CardsBloc, CardsState>(
      buildWhen: BlocBuildWhen.cardsList,
      builder: (context, state) {
        if (state.listStatus == RequestStatus.loading ||
            state.listStatus == RequestStatus.initial) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(pinned: true, title: Text(l10n.myCards)),
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
          );
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar(pinned: true, title: Text(l10n.myCards)),
            SliverPadding(
              padding: EdgeInsets.all(padding),
              sliver: SliverList.separated(
                itemCount: state.cards.length,
                separatorBuilder: (_, _) => const SizedBox(height: 20),
                itemBuilder: (_, i) {
                  final card = state.cards[i];
                  return _CardListItem(
                    card: card,
                    onTap: () => context.pushCardDetails(card.id),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CardListItem extends StatelessWidget {
  const _CardListItem({required this.card, required this.onTap});

  final BankCard card;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isFrozen = card.status == CardStatus.frozen;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          BankingCard(
            title:
                card.type == CardType.virtual ? l10n.virtual : l10n.physical,
            subtitle: card.cardNumber,
            balance: card.balance,
            currency: card.currency,
            gradientColors: card.gradientColors.map(Color.new).toList(),
          ),
          if (isFrozen)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.ac_unit, color: Colors.white, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          l10n.frozen,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
