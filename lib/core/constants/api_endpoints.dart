/// Central API route definitions for the BankX backend.
abstract final class ApiEndpoints {
  static const String baseUrl = String.fromEnvironment(
    'BANKX_API_BASE_URL',
    defaultValue: 'https://api.bankx.com/v1',
  );

  // Auth
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const refreshToken = '/auth/refresh';
  static const logout = '/auth/logout';
  static const forgotPassword = '/auth/forgot-password';
  static const verifyOtp = '/auth/verify-otp';
  static const resetPassword = '/auth/reset-password';

  // Dashboard
  static const dashboard = '/dashboard';
  static const analytics = '/dashboard/analytics';

  // Accounts
  static String accountById(String id) => '/accounts/$id';

  // Transactions
  static const transactions = '/transactions';
  static String transactionById(String id) => '/transactions/$id';

  // Transfer
  static const transfers = '/transfers';
  static const beneficiaries = '/beneficiaries';

  // Cards
  static const cards = '/cards';
  static String cardById(String id) => '/cards/$id';
  static String freezeCard(String id) => '/cards/$id/freeze';

  // Payments
  static const qrPayment = '/payments/qr';
  static const billPayment = '/payments/bills';

  // Notifications
  static const notifications = '/notifications';
  static String markNotificationRead(int index) =>
      '/notifications/$index/read';

  // Profile
  static const profile = '/profile';

  // Settings
  static const settings = '/settings';
}
