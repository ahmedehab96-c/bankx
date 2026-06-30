import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/qr/qr_code_display.dart';
import '../../../../core/qr/qr_payment_codec.dart';
import '../../../../core/qr/qr_scanner_view.dart';
import '../../../../core/security/sensitive_screen_wrapper.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../localization/app_localizations.dart';
import '../bloc/payments_bloc.dart';
import '../bloc/payments_state.dart';

/// QR payment screen with scan and personal QR code tabs.
class QrPaymentScreen extends StatefulWidget {
  const QrPaymentScreen({super.key});

  @override
  State<QrPaymentScreen> createState() => _QrPaymentScreenState();
}

class _QrPaymentScreenState extends State<QrPaymentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final padding = Responsive.horizontalPadding(context);

    return SensitiveScreenWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.qrPayment),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: l10n.scanToPay),
              Tab(text: l10n.myQrCode),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _ScanTab(padding: padding),
            BlocBuilder<PaymentsBloc, PaymentsState>(
              builder: (context, state) {
                return _MyQrTab(
                  padding: padding,
                  displayName:
                      state.qrPaymentData?.user.name ?? 'Ahmed Mohammed',
                  qrData: state.qrPaymentData == null
                      ? null
                      : QrPaymentCodec.encodeReceive(
                          accountNumber: state.qrPaymentData!.accountNumber,
                          iban: state.qrPaymentData!.iban,
                          name: state.qrPaymentData!.user.name,
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ScanTab extends StatelessWidget {
  const _ScanTab({required this.padding});

  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  QrScannerView(
                    onScanned: (data) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'QR scanned: ${data['name'] ?? 'Unknown'}',
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.accentCyan, width: 3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Point camera at QR code to pay',
            style: GoogleFonts.inter(color: Theme.of(context).hintColor),
          ),
        ],
      ),
    );
  }
}

class _MyQrTab extends StatelessWidget {
  const _MyQrTab({
    required this.padding,
    required this.displayName,
    required this.qrData,
  });

  final double padding;
  final String displayName;
  final String? qrData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBlue.withValues(alpha: 0.15),
                  blurRadius: 24,
                ),
              ],
            ),
            child: qrData == null
                ? const Icon(
                    Icons.qr_code_2_rounded,
                    size: 200,
                    color: AppColors.primaryDark,
                  )
                : QrCodeDisplay(data: qrData!, size: 200),
          ),
          const SizedBox(height: 24),
          Text(
            displayName,
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Text(
            'Scan to pay me',
            style: GoogleFonts.inter(color: Theme.of(context).hintColor),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
