import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../shared/bloc/request_status.dart';
import '../bloc/payments_bloc.dart';
import '../bloc/payments_event.dart';
import '../bloc/payments_state.dart';

/// Bill payment screen with category selection.
class BillPaymentScreen extends StatefulWidget {
  const BillPaymentScreen({super.key});

  @override
  State<BillPaymentScreen> createState() => _BillPaymentScreenState();
}

class _BillPaymentScreenState extends State<BillPaymentScreen> {
  static const _billTypes = ['electricity', 'water', 'internet', 'mobile'];

  int _selectedCategory = 0;
  final _accountController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _accountController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _pay() {
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) return;

    context.read<PaymentsBloc>().add(
      BillPaymentSubmitted(
        amount: amount,
        billType: _billTypes[_selectedCategory],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final padding = Responsive.horizontalPadding(context);
    final categories = [
      (Icons.bolt_rounded, l10n.electricity, AppColors.warning),
      (Icons.water_drop_outlined, l10n.water, AppColors.accentCyan),
      (Icons.wifi_rounded, l10n.internet, AppColors.primaryBlue),
      (Icons.phone_android_rounded, l10n.mobile, AppColors.success),
    ];

    return BlocListener<PaymentsBloc, PaymentsState>(
      listenWhen: (previous, current) =>
          previous.billStatus != current.billStatus,
      listener: (context, state) {
        if (state.billStatus == RequestStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Bill paid successfully!')),
          );
        }
      },
      child: BlocBuilder<PaymentsBloc, PaymentsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.billPayment)),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.selectCategory,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 14),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Responsive.gridCrossAxisCount(context),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.3,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (_, i) {
                      final (icon, label, color) = categories[i];
                      final selected = _selectedCategory == i;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedCategory = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: selected
                                ? color.withValues(alpha: 0.15)
                                : Theme.of(context).cardTheme.color,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: selected ? color : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(icon, color: color, size: 32),
                              const SizedBox(height: 8),
                              Text(
                                label,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  AppTextField(
                    controller: _accountController,
                    label: l10n.accountNumber,
                    prefixIcon: Icons.numbers,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _amountController,
                    label: l10n.amount,
                    prefixIcon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 32),
                  AppButton(
                    label: l10n.payNow,
                    isLoading: state.billStatus == RequestStatus.loading,
                    onPressed: _pay,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
