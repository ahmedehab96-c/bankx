import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../shared/bloc/request_status.dart';
import '../bloc/transfer_bloc.dart';
import '../bloc/transfer_state.dart';

/// List of saved transfer beneficiaries.
class BeneficiariesScreen extends StatelessWidget {
  const BeneficiariesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final padding = Responsive.horizontalPadding(context);

    return BlocBuilder<TransferBloc, TransferState>(
      builder: (context, state) {
        if (state.beneficiariesStatus == RequestStatus.loading) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.beneficiaries)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text(l10n.beneficiaries)),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.pushAddBeneficiary(),
            icon: const Icon(Icons.person_add_outlined),
            label: Text(l10n.addBeneficiary),
          ),
          body: ListView.separated(
            padding: EdgeInsets.all(padding),
            itemCount: state.beneficiaries.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (_, i) {
              final b = state.beneficiaries[i];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: Color(b.color).withValues(alpha: 0.15),
                      child: Text(
                        b.avatarInitials,
                        style: GoogleFonts.inter(
                          color: Color(b.color),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            b.name,
                            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${b.bankName} • ${b.accountNumber}',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => context.pushTransfer(),
                      icon: const Icon(
                        Icons.send_rounded,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
