import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_screen_scaffold.dart';
import '../../../../core/widgets/detail_info_tile.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../../../shared/domain/entities/transaction.dart';
import '../bloc/transactions_bloc.dart';
import '../bloc/transactions_state.dart';

/// Single transaction detail view.
class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key, required this.transactionId});

  final String transactionId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        if (state.detailsStatus == RequestStatus.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final tx = state.selectedTransaction;
        if (tx == null) {
          return NotFoundBody(
            message: state.errorMessage ?? 'Transaction not found',
          );
        }

        final isIncome = tx.type == TransactionType.income;

        return AppScreenScaffold.scroll(
          title: l10n.transactionDetails,
          body: Column(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: (isIncome ? AppColors.income : AppColors.expense)
                      .withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                  color: isIncome ? AppColors.income : AppColors.expense,
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                tx.title,
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${isIncome ? '+' : '-'}${AppFormatters.currency(tx.amount, symbol: tx.currency)}',
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: isIncome ? AppColors.income : AppColors.expense,
                ),
              ),
              const SizedBox(height: 32),
              DetailInfoCard(
                rows: [
                  DetailInfoRow(l10n.status, _statusLabel(l10n, tx.status)),
                  DetailInfoRow(l10n.date, AppFormatters.dateTime(tx.date)),
                  DetailInfoRow(l10n.category, tx.category),
                  DetailInfoRow(l10n.reference, tx.reference),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _statusLabel(AppLocalizations l10n, TransactionStatus status) {
    return switch (status) {
      TransactionStatus.completed => l10n.completed,
      TransactionStatus.pending => l10n.pending,
      TransactionStatus.failed => l10n.failed,
    };
  }
}
