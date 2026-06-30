import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/profile_tile.dart';
import '../../../../localization/app_localizations.dart';

/// Help and support with FAQ and contact options.
class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final padding = Responsive.horizontalPadding(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.helpSupport)),
      body: ListView(
        padding: EdgeInsets.all(padding),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How can we help?',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Our support team is available 24/7',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ProfileTile(
            title: l10n.faq,
            icon: Icons.quiz_outlined,
            onTap: () => _showFaq(context),
          ),
          ProfileTile(
            title: l10n.liveChat,
            icon: Icons.chat_bubble_outline_rounded,
            iconColor: AppColors.success,
            onTap: () {},
          ),
          ProfileTile(
            title: l10n.contactUs,
            icon: Icons.email_outlined,
            subtitle: 'support@bankx.com',
            showDivider: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  void _showFaq(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        builder: (_, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.all(24),
          children: const [
            _FaqItem(
              question: 'How do I transfer money?',
              answer:
                  'Go to Transfer from the home screen, select an account and beneficiary, enter the amount and confirm.',
            ),
            _FaqItem(
              question: 'How do I freeze my card?',
              answer:
                  'Navigate to My Cards, select a card, and tap Freeze Card to temporarily disable it.',
            ),
            _FaqItem(
              question: 'Is my money safe?',
              answer:
                  'Yes. BankX uses bank-grade encryption and multi-factor authentication to protect your funds.',
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  const _FaqItem({required this.question, required this.answer});

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            answer,
            style: GoogleFonts.inter(
              color: Theme.of(context).hintColor,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
