import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/transaction_tile.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../../transactions/presentation/bloc/transactions_bloc.dart';
import '../../../transactions/presentation/bloc/transactions_event.dart';
import '../../../transactions/presentation/bloc/transactions_state.dart';
import '../../domain/usecases/ai_usecases.dart';

/// Natural language transaction search.
class SmartSearchPage extends StatefulWidget {
  const SmartSearchPage({super.key});

  @override
  State<SmartSearchPage> createState() => _SmartSearchPageState();
}

class _SmartSearchPageState extends State<SmartSearchPage> {
  final _controller = TextEditingController();
  String? _interpretation;
  List<String> _matchedIds = [];
  double _total = 0;
  bool _searching = false;

  static const _examples = [
    'Transactions from last week',
    'Payments above 500 AED',
    'Restaurant expenses',
  ];

  Future<void> _search([String? query]) async {
    final q = (query ?? _controller.text).trim();
    if (q.isEmpty) return;
    setState(() => _searching = true);

    final useCase = getIt<SmartSearchUseCase>();
    final result = await useCase(q);

    result.fold(
      (f) => setState(() {
        _searching = false;
        _interpretation = f.message;
      }),
      (r) => setState(() {
        _searching = false;
        _interpretation = r.interpretation;
        _matchedIds = r.transactionIds;
        _total = r.totalAmount;
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<TransactionsBloc>().add(const TransactionsLoaded());
  }

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.horizontalPadding(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Smart Search')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(padding),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search in plain language...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searching
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () => _search(),
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onSubmitted: (_) => _search(),
            ),
          ),
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: padding),
              itemCount: _examples.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (_, i) => ActionChip(
                label: Text(_examples[i], style: const TextStyle(fontSize: 12)),
                onPressed: () {
                  _controller.text = _examples[i];
                  _search(_examples[i]);
                },
              ),
            ),
          ),
          if (_interpretation != null)
            Padding(
              padding: EdgeInsets.all(padding),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _interpretation!,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  if (_total > 0)
                    Text(
                      '${_total.toStringAsFixed(0)} AED',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                ],
              ),
            ),
          Expanded(
            child: BlocBuilder<TransactionsBloc, TransactionsState>(
              builder: (context, state) {
                if (state.listStatus == RequestStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                final txs = state.transactions
                    .where((t) => _matchedIds.contains(t.id))
                    .toList();
                if (_matchedIds.isEmpty && _interpretation != null) {
                  return const Center(child: Text('No matching transactions'));
                }
                return ListView.builder(
                  itemCount: txs.length,
                  itemBuilder: (_, i) =>
                      TransactionTile(transaction: txs[i], onTap: () {}),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
