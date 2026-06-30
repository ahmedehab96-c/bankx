import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../shared/bloc/request_status.dart';
import '../bloc/transfer_bloc.dart';
import '../bloc/transfer_event.dart';
import '../bloc/transfer_state.dart';

/// Form to add a new transfer beneficiary.
class AddBeneficiaryScreen extends StatefulWidget {
  const AddBeneficiaryScreen({super.key});

  @override
  State<AddBeneficiaryScreen> createState() => _AddBeneficiaryScreenState();
}

class _AddBeneficiaryScreenState extends State<AddBeneficiaryScreen> {
  final _nameController = TextEditingController();
  final _bankController = TextEditingController();
  final _accountController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _bankController.dispose();
    _accountController.dispose();
    super.dispose();
  }

  void _save() {
    context.read<TransferBloc>().add(
      AddBeneficiarySubmitted(
        name: _nameController.text,
        bankName: _bankController.text,
        accountNumber: _accountController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final padding = Responsive.horizontalPadding(context);

    return BlocConsumer<TransferBloc, TransferState>(
      listenWhen: (previous, current) =>
          previous.addBeneficiaryStatus != current.addBeneficiaryStatus,
      listener: (context, state) {
        if (state.addBeneficiaryStatus == RequestStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).saveBeneficiary),
            ),
          );
          context.pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(l10n.addBeneficiary)),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              children: [
                AppTextField(
                  controller: _nameController,
                  label: l10n.fullName,
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _bankController,
                  label: l10n.bankName,
                  prefixIcon: Icons.account_balance_outlined,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _accountController,
                  label: l10n.accountNumber,
                  prefixIcon: Icons.numbers,
                ),
                const SizedBox(height: 32),
                AppButton(
                  label: l10n.saveBeneficiary,
                  isLoading:
                      state.addBeneficiaryStatus == RequestStatus.loading,
                  onPressed: _save,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
