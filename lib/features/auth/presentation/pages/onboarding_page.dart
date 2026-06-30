import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../localization/app_localizations.dart';

/// Three-page onboarding flow introducing BankX features.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.goLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pages = [
      _OnboardingPage(
        icon: Icons.account_balance_wallet_rounded,
        title: l10n.onboardingTitle1,
        description: l10n.onboardingDesc1,
        gradient: AppColors.primaryGradient,
      ),
      _OnboardingPage(
        icon: Icons.send_rounded,
        title: l10n.onboardingTitle2,
        description: l10n.onboardingDesc2,
        gradient: const LinearGradient(
          colors: [Color(0xFF5856D6), Color(0xFF007AFF)],
        ),
      ),
      _OnboardingPage(
        icon: Icons.shield_rounded,
        title: l10n.onboardingTitle3,
        description: l10n.onboardingDesc3,
        gradient: const LinearGradient(
          colors: [Color(0xFF34C759), Color(0xFF007AFF)],
        ),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.horizontalPadding(context),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.goLogin(),
                  child: Text(l10n.skip),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemBuilder: (_, i) => pages[i],
                ),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: AppColors.primaryBlue,
                  dotColor: AppColors.primaryBlue.withValues(alpha: 0.2),
                ),
              ),
              const SizedBox(height: 32),
              AppButton(
                label: _currentPage == 2 ? l10n.getStarted : l10n.next,
                onPressed: _nextPage,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
  });

  final IconData icon;
  final String title;
  final String description;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryBlue.withValues(alpha: 0.3),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Icon(icon, size: 64, color: Colors.white),
        ),
        const SizedBox(height: 48),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 16,
            height: 1.6,
            color: Theme.of(context).hintColor,
          ),
        ),
      ],
    );
  }
}
