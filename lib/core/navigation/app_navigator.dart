import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_routes.dart';

/// Global navigator key for deep links from background services.
final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

/// Typed navigation helpers — use instead of raw path strings.
extension AppNavigator on BuildContext {
  // ── Go (replace stack) ─────────────────────────────────────
  void goSplash() => go(AppRoutes.splash);
  void goOnboarding() => go(AppRoutes.onboarding);
  void goLogin() => go(AppRoutes.login);
  void goHome() => go(AppRoutes.home);

  // ── Push (stack overlay) ───────────────────────────────────
  void pushRegister() => push(AppRoutes.register);
  void pushForgotPassword() => push(AppRoutes.forgotPassword);
  void pushOtp() => push(AppRoutes.otp);

  void pushAccountDetails(String id) => push(AppRoutes.account(id));
  void pushTransactionDetails(String id) => push(AppRoutes.transaction(id));
  void pushTransactionHistory() => push(AppRoutes.transactionHistory);
  void pushTransfer() => push(AppRoutes.transfer);
  void pushBeneficiaries() => push(AppRoutes.beneficiaries);
  void pushAddBeneficiary() => push(AppRoutes.addBeneficiary);
  void pushCardDetails(String id) => push(AppRoutes.card(id));
  void pushFreezeCard(String id) => push(AppRoutes.freezeCardPath(id));
  void pushQrPayment() => push(AppRoutes.qrPayment);
  void pushBillPayment() => push(AppRoutes.billPayment);
  void pushNotifications() => push(AppRoutes.notifications);
  void pushSecurity() => push(AppRoutes.security);
  void pushSettings() => push(AppRoutes.settings);
  void pushHelp() => push(AppRoutes.help);

  void pushAiAssistant() => push(AppRoutes.aiAssistant);
  void pushBudget() => push(AppRoutes.budget);
  void pushSmartSearch() => push(AppRoutes.smartSearch);
  void pushReceiptOcr() => push(AppRoutes.receiptOcr);
  void pushVoiceBanking() => push(AppRoutes.voiceBanking);
  void pushCurrency() => push(AppRoutes.currency);
  void pushInvestments() => push(AppRoutes.investments);
  void pushRoute(String path) => push(path);

  /// Switch shell tab without stacking routes.
  void goToTab(int index) {
    final shell = StatefulNavigationShell.maybeOf(this);
    shell?.goBranch(index);
  }

  void goToCardsTab() => go(AppRoutes.myCards);
}
