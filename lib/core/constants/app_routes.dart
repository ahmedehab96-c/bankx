/// Centralized route paths and typed navigation helpers.
abstract final class AppRoutes {
  // ── Auth flow ──────────────────────────────────────────────
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const otp = '/otp';

  // ── Main shell tabs ────────────────────────────────────────
  static const home = '/home';
  static const analytics = '/analytics';
  static const myCards = '/cards';
  static const profile = '/profile';

  // ── Banking features ───────────────────────────────────────
  static const transactionHistory = '/transaction-history';
  static const transfer = '/transfer';
  static const beneficiaries = '/beneficiaries';
  static const addBeneficiary = '/beneficiaries/add';
  static const qrPayment = '/qr-payment';
  static const billPayment = '/bill-payment';
  static const notifications = '/notifications';
  static const security = '/security';
  static const settings = '/settings';
  static const help = '/help';

  // ── AI features ────────────────────────────────────────────
  static const aiAssistant = '/ai-assistant';
  static const budget = '/budget';
  static const smartSearch = '/smart-search';
  static const receiptOcr = '/receipt-ocr';
  static const voiceBanking = '/voice-banking';
  static const currency = '/currency';
  static const investments = '/investments';

  // ── Parameterized routes (patterns) ────────────────────────
  static const accountDetails = '/account/:id';
  static const transactionDetails = '/transaction/:id';
  static const cardDetails = '/card/:id';
  static const freezeCard = '/card/:id/freeze';

  // ── Typed path builders ─────────────────────────────────────
  static String account(String id) => '/account/$id';
  static String transaction(String id) => '/transaction/$id';
  static String card(String id) => '/card/$id';
  static String freezeCardPath(String id) => '/card/$id/freeze';

  /// Routes accessible without authentication.
  static const publicRoutes = {
    splash,
    onboarding,
    login,
    register,
    forgotPassword,
    otp,
  };

  /// Shell tab routes — use [goBranch] instead of push when switching tabs.
  static const shellRoutes = {home, analytics, myCards, profile};
}
