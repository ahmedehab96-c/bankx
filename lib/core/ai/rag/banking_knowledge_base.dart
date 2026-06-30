import 'knowledge_chunk.dart';

/// Curated BankX banking knowledge — offline RAG corpus.
abstract final class BankingKnowledgeBase {
  static const List<KnowledgeChunk> chunks = [
    KnowledgeChunk(
      id: 'transfer_limits',
      title: 'Transfer limits',
      content:
          'Daily local transfer limit is 50,000 AED. International transfers '
          'require OTP verification above 10,000 AED. Transfers are processed '
          'instantly for UAE banks during business hours.',
      keywords: [
        'transfer',
        'limit',
        'daily',
        'international',
        'otp',
        'حوالة',
        'حد',
      ],
    ),
    KnowledgeChunk(
      id: 'transfer_fees',
      title: 'Transfer fees',
      content:
          'Local AED transfers between BankX accounts are free. Other UAE banks '
          'cost 2 AED per transfer. International SWIFT transfers cost 25 AED '
          'plus correspondent bank fees.',
      keywords: ['fee', 'transfer', 'cost', 'swift', 'رسوم', 'تحويل'],
    ),
    KnowledgeChunk(
      id: 'card_freeze',
      title: 'Card security',
      content:
          'You can freeze or unfreeze your debit/credit card instantly from '
          'My Cards. Frozen cards decline all new transactions but standing '
          'orders may still process.',
      keywords: ['card', 'freeze', 'block', 'بطاقة', 'تجميد'],
    ),
    KnowledgeChunk(
      id: 'qr_payments',
      title: 'QR payments',
      content:
          'Scan merchant QR codes from the QR Payment screen. Maximum single '
          'QR payment is 5,000 AED without additional verification.',
      keywords: ['qr', 'scan', 'payment', 'دفع', 'رمز'],
    ),
    KnowledgeChunk(
      id: 'bill_payment',
      title: 'Bill payments',
      content:
          'Pay electricity, water, telecom, and government bills from Bill '
          'Payment. Saved billers can be paid in one tap. Receipts are stored '
          'in transaction history.',
      keywords: ['bill', 'utility', 'electricity', 'فاتورة', 'دفع'],
    ),
    KnowledgeChunk(
      id: 'budget_ai',
      title: 'AI budgeting',
      content:
          'Smart Budget tracks monthly spending by category. AI predicts '
          'overspending when you reach 90% of a category limit and suggests '
          'savings opportunities.',
      keywords: ['budget', 'spending', 'ai', 'ميزانية', 'مصاريف'],
    ),
    KnowledgeChunk(
      id: 'security_pin',
      title: 'Security policy',
      content:
          'BankX never asks for your password, PIN, or OTP in chat. Enable '
          'biometric login and PIN lock in Security settings. Report suspicious '
          'activity immediately.',
      keywords: [
        'security',
        'pin',
        'password',
        'otp',
        'fraud',
        'أمان',
        'رقم سري',
      ],
    ),
    KnowledgeChunk(
      id: 'support_hours',
      title: 'Customer support',
      content:
          '24/7 in-app chat and phone support. For disputed transactions, open '
          'a case from transaction details within 60 days.',
      keywords: ['support', 'help', 'dispute', 'دعم', 'مساعدة'],
    ),
    KnowledgeChunk(
      id: 'transfer_limits_ar',
      title: 'حدود التحويل',
      locale: 'ar',
      content:
          'حد التحويل المحلي اليومي 50,000 درهم. التحويلات الدولية فوق '
          '10,000 درهم تتطلب رمز OTP. التحويلات للبنوك الإماراتية فورية '
          'خلال ساعات العمل.',
      keywords: ['حوالة', 'تحويل', 'حد', 'دولي', 'transfer'],
    ),
    KnowledgeChunk(
      id: 'security_pin_ar',
      title: 'الأمان',
      locale: 'ar',
      content:
          'BankX لا يطلب كلمة المرور أو الرقم السري أو OTP في المحادثة. '
          'فعّل البصمة وقفل PIN من إعدادات الأمان.',
      keywords: ['أمان', 'رقم سري', 'otp', 'security', 'pin'],
    ),
  ];
}
