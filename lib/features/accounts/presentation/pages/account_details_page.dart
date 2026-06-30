import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_screen_scaffold.dart';
import '../../../../core/widgets/banking_card.dart';
import '../../../../core/widgets/detail_info_tile.dart';
import '../../../../core/widgets/statistics_card.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../shared/bloc/request_status.dart';
import '../bloc/accounts_bloc.dart';
import '../bloc/accounts_state.dart';

/// Detailed view of a single bank account.
class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key, required this.accountId});

  final String accountId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        if (state.status == RequestStatus.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final account = state.account;
        if (account == null) {
          return NotFoundBody(
            message: state.errorMessage ?? 'Account not found',
          );
        }

        return AppScreenScaffold.scroll(
          title: l10n.accountDetails,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BankingCard(
                title: account.name,
                subtitle: account.type,
                balance: account.balance,
                currency: account.currency,
                gradientColors: [Color(account.color), AppColors.primaryDark],
              ),
              const SizedBox(height: 28),
              DetailInfoTile(
                label: l10n.accountNumber,
                value: account.accountNumber,
                onCopy: () => _copy(context, account.accountNumber),
              ),
              DetailInfoTile(
                label: l10n.iban,
                value: account.iban,
                onCopy: () => _copy(context, account.iban),
              ),
              DetailInfoTile(
                label: l10n.availableBalance,
                value:
                    '${account.currency} ${account.balance.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: StatisticsCard(
                      title: l10n.income,
                      value: 'AED 18,500',
                      icon: Icons.arrow_downward_rounded,
                      color: AppColors.income,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: StatisticsCard(
                      title: l10n.expense,
                      value: 'AED 4,230',
                      icon: Icons.arrow_upward_rounded,
                      color: AppColors.expense,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => context.pushTransfer(),
                  icon: const Icon(Icons.swap_horiz),
                  label: Text(l10n.transfer),
                  style: FilledButton.styleFrom(
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

  void _copy(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${AppLocalizations.of(context).copy}: $text')),
    );
  }
}
