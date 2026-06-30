import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../../../shared/domain/entities/beneficiary.dart';
import '../bloc/transfer_bloc.dart';
import '../bloc/transfer_event.dart';
import '../bloc/transfer_state.dart';

/// Transfer money flow with account and beneficiary selection.
class TransferMoneyScreen extends StatefulWidget {
  const TransferMoneyScreen({super.key});

  @override
  State<TransferMoneyScreen> createState() => _TransferMoneyScreenState();
}

class _TransferMoneyScreenState extends State<TransferMoneyScreen> {
  String? _selectedAccountId;
  Beneficiary? _selectedBeneficiary;
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _transfer() {
    if (_selectedAccountId == null || _selectedBeneficiary == null) return;

    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) return;

    context.read<TransferBloc>().add(
      TransferSubmitted(
        fromAccountId: _selectedAccountId!,
        beneficiaryId: _selectedBeneficiary!.id,
        amount: amount,
        note: _noteController.text.isEmpty ? null : _noteController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final padding = Responsive.horizontalPadding(context);

    return BlocConsumer<TransferBloc, TransferState>(
      listenWhen: (previous, current) =>
          previous.submitStatus != current.submitStatus,
      listener: (context, state) {
        if (state.submitStatus == RequestStatus.success) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Transfer successful!')));
          context.pop();
        }
      },
      builder: (context, state) {
        if (state.loadStatus == RequestStatus.loading) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.transferMoney)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.transferMoney),
            actions: [
              TextButton(
                onPressed: () => context.pushBeneficiaries(),
                child: Text(l10n.beneficiaries),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.fromAccount,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.accounts.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (_, index) {
                    final acc = state.accounts[index];
                    return _SelectionTile(
                      title: acc.name,
                      subtitle:
                          '${acc.currency} ${acc.balance.toStringAsFixed(2)}',
                      selected: _selectedAccountId == acc.id,
                      onTap: () => setState(() => _selectedAccountId = acc.id),
                    );
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.toBeneficiary,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.beneficiaries.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (_, index) {
                    final b = state.beneficiaries[index];
                    return _SelectionTile(
                      title: b.name,
                      subtitle: b.bankName,
                      selected: _selectedBeneficiary?.id == b.id,
                      leading: CircleAvatar(
                        backgroundColor: Color(b.color).withValues(alpha: 0.15),
                        child: Text(
                          b.avatarInitials,
                          style: TextStyle(
                            color: Color(b.color),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      onTap: () => setState(() => _selectedBeneficiary = b),
                    );
                  },
                ),
                const SizedBox(height: 24),
                AppTextField(
                  controller: _amountController,
                  label: l10n.amount,
                  prefixIcon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _noteController,
                  label: l10n.note,
                  prefixIcon: Icons.note_outlined,
                ),
                const SizedBox(height: 32),
                AppButton(
                  label: l10n.continueAction,
                  isLoading: state.submitStatus == RequestStatus.loading,
                  onPressed: _transfer,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SelectionTile extends StatelessWidget {
  const _SelectionTile({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
    this.leading,
  });

  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: selected
            ? AppColors.primaryBlue.withValues(alpha: 0.08)
            : Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                if (leading != null) ...[leading!, const SizedBox(width: 12)],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (selected)
                  const Icon(Icons.check_circle, color: AppColors.primaryBlue),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
