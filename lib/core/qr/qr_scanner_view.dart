import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../qr/qr_payment_codec.dart';

/// Embeds [MobileScanner] inside the existing QR scan frame layout.
class QrScannerView extends StatelessWidget {
  const QrScannerView({super.key, required this.onScanned});

  final ValueChanged<Map<String, dynamic>> onScanned;

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      onDetect: (capture) {
        for (final barcode in capture.barcodes) {
          final raw = barcode.rawValue;
          if (raw == null) continue;
          final decoded = QrPaymentCodec.decode(raw);
          if (decoded != null) {
            onScanned(decoded);
            return;
          }
        }
      },
    );
  }
}
