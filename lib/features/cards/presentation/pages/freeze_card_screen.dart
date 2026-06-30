import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../../../shared/domain/entities/card_model.dart';
import '../bloc/cards_bloc.dart';
import '../bloc/cards_event.dart';
import '../bloc/cards_state.dart';

/// Freeze or unfreeze card security screen.
class FreezeCardScreen extends StatefulWidget {
  const FreezeCardScreen({super.key, required this.cardId});

  final String cardId;

  @override
  State<FreezeCardScreen> createState() => _FreezeCardScreenState();
}

class _FreezeCardScreenState extends State<FreezeCardScreen> {
  bool? _wasFrozen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final padding = Responsive.horizontalPadding(context);

    return BlocConsumer<CardsBloc, CardsState>(
      listenWhen: (previous, current) =>
          previous.freezeStatus != current.freezeStatus,
      listener: (context, state) {
        if (state.freezeStatus == RequestStatus.success && _wasFrozen != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_wasFrozen! ? 'Card unfrozen' : 'Card frozen'),
            ),
          );
          _wasFrozen = null;
          context.pop();
        }
      },
      builder: (context, state) {
        if (state.detailsStatus == RequestStatus.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final card = state.selectedCard;
        if (card == null) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text(state.errorMessage ?? 'Card not found')),
          );
        }

        final isFrozen = card.status == CardStatus.frozen;

        return Scaffold(
          appBar: AppBar(
            title: Text(isFrozen ? l10n.unfreezeCard : l10n.freezeCard),
          ),
          body: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              children: [
                const Spacer(),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: (isFrozen ? AppColors.accentCyan : AppColors.warning)
                        .withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFrozen ? Icons.lock_open_rounded : Icons.ac_unit_rounded,
                    size: 56,
                    color: isFrozen ? AppColors.accentCyan : AppColors.warning,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  isFrozen ? l10n.unfreezeCard : l10n.freezeCard,
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  isFrozen ? l10n.unfreezeCardDesc : l10n.freezeCardDesc,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    height: 1.5,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                const Spacer(),
                AppButton(
                  label: isFrozen ? l10n.unfreezeCard : l10n.freezeCard,
                  isLoading: state.freezeStatus == RequestStatus.loading,
                  onPressed: () {
                    _wasFrozen = isFrozen;
                    context
                        .read<CardsBloc>()
                        .add(CardFreezeToggled(widget.cardId));
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
