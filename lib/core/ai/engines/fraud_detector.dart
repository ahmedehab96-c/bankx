import '../models/ai_models.dart';

/// Fraud detection engine — architecture for enterprise fraud monitoring.
class FraudDetector {
  const FraudDetector();

  static const int failedLoginThreshold = 3;
  static const int rapidTransferWindowSeconds = 60;
  static const int rapidTransferThreshold = 3;
  static const double largePaymentThresholdAed = 10000;

  List<FraudSignal> analyze({
    int failedLoginCount = 0,
    bool abnormalLocation = false,
    List<TransferEvent> recentTransfers = const [],
    double? lastTransferAmount,
    double averageTransferAmount = 500,
  }) {
    final signals = <FraudSignal>[];
    final now = DateTime.now();

    if (failedLoginCount >= failedLoginThreshold) {
      signals.add(
        FraudSignal(
          type: FraudSignalType.repeatedFailedLogin,
          description:
              '$failedLoginCount failed login attempts detected. Account may be under attack.',
          riskScore: 0.8,
          detectedAt: now,
        ),
      );
    }

    if (abnormalLocation) {
      signals.add(
        FraudSignal(
          type: FraudSignalType.abnormalLocation,
          description:
              'Login or transaction from an unusual location detected.',
          riskScore: 0.7,
          detectedAt: now,
        ),
      );
    }

    if (recentTransfers.length >= rapidTransferThreshold) {
      final window = recentTransfers.last.timestamp
          .difference(recentTransfers.first.timestamp)
          .inSeconds;
      if (window <= rapidTransferWindowSeconds) {
        signals.add(
          FraudSignal(
            type: FraudSignalType.rapidTransfers,
            description:
                '${recentTransfers.length} transfers within $window seconds.',
            riskScore: 0.75,
            detectedAt: now,
          ),
        );
      }
    }

    if (lastTransferAmount != null &&
        lastTransferAmount > largePaymentThresholdAed &&
        lastTransferAmount > averageTransferAmount * 5) {
      signals.add(
        FraudSignal(
          type: FraudSignalType.largeUnusualPayment,
          description:
              'Large payment of ${lastTransferAmount.toStringAsFixed(0)} AED '
              '— significantly above your average.',
          riskScore: 0.65,
          detectedAt: now,
        ),
      );
    }

    return signals;
  }

  List<SmartAlert> toAlerts(List<FraudSignal> signals) {
    return signals
        .map(
          (s) => SmartAlert(
            id: 'fraud_${s.type.name}_${s.detectedAt.millisecondsSinceEpoch}',
            type: SmartAlertType.suspiciousActivity,
            title: 'Security Alert',
            body: s.description,
            severity: s.riskScore >= 0.75
                ? AlertSeverity.critical
                : AlertSeverity.warning,
            createdAt: s.detectedAt,
            actionRoute: '/security',
          ),
        )
        .toList();
  }
}

class TransferEvent {
  const TransferEvent({required this.amount, required this.timestamp});

  final double amount;
  final DateTime timestamp;
}
