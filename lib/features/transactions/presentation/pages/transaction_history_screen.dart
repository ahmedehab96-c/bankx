import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/performance/bloc_build_when.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/transaction_tile.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../../../shared/domain/entities/transaction.dart';
import '../bloc/transactions_bloc.dart';
import '../bloc/transactions_state.dart';

/// Full transaction history with search and filters.
class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  String _filter = 'all';
  final _searchController = TextEditingController();

  List<Transaction> _filtered(List<Transaction> transactions) {
    var list = transactions;
    if (_filter == 'income') {
      list = list.where((t) => t.type == TransactionType.income).toList();
    } else if (_filter == 'expense') {
      list = list.where((t) => t.type == TransactionType.expense).toList();
    }
    final query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      list = list
          .where(
            (t) =>
                t.title.toLowerCase().contains(query) ||
                t.subtitle.toLowerCase().contains(query),
          )
          .toList();
    }
    return list;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final padding = Responsive.horizontalPadding(context);

    return BlocBuilder<TransactionsBloc, TransactionsState>(
      buildWhen: BlocBuildWhen.transactionsList,
      builder: (context, state) {
        if (state.listStatus == RequestStatus.loading) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.transactionHistory)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final filtered = _filtered(state.transactions);

        return Scaffold(
          appBar: AppBar(title: Text(l10n.transactionHistory)),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(padding, 8, padding, 0),
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: l10n.searchTransactions,
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Row(
                  children: [
                    _FilterChip(
                      label: l10n.all,
                      selected: _filter == 'all',
                      onTap: () => setState(() => _filter = 'all'),
                    ),
                    _FilterChip(
                      label: l10n.income,
                      selected: _filter == 'income',
                      onTap: () => setState(() => _filter = 'income'),
                    ),
                    _FilterChip(
                      label: l10n.expense,
                      selected: _filter == 'expense',
                      onTap: () => setState(() => _filter = 'expense'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(padding),
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (_, i) {
                    final tx = filtered[i];
                    return TransactionTile(
                      transaction: tx,
                      onTap: () => context.pushTransactionDetails(tx.id),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        showCheckmark: false,
      ),
    );
  }
}
