import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../ai_config.dart';

/// SHA-256 certificate pinning for remote AI HTTP clients.
abstract final class CertificatePinner {
  static List<String> parsePins(String raw) => raw
      .split(',')
      .map((p) => p.trim().toLowerCase())
      .where((p) => p.isNotEmpty)
      .toList();

  static String fingerprintSha256Hex(X509Certificate certificate) {
    final digest = sha256.convert(certificate.der);
    return digest.bytes
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join();
  }

  static bool matches(X509Certificate certificate, List<String> allowedPins) {
    if (allowedPins.isEmpty) return true;
    final fp = fingerprintSha256Hex(certificate);
    return allowedPins.contains(fp);
  }

  static void applyIfEnabled(Dio dio) {
    if (kIsWeb || !AiConfig.certPinningEnabled) return;
    final pins = parsePins(AiConfig.certPins);
    if (pins.isEmpty) return;

    dio.httpClientAdapter = IOHttpClientAdapter(
      validateCertificate: (certificate, host, port) {
        if (certificate == null) return false;
        return matches(certificate, pins);
      },
    );
  }
}

/// Builds Dio instances for OpenAI-compatible AI providers.
abstract final class AiDioFactory {
  static Dio create({
    required String baseUrl,
    required Map<String, String> headers,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 90),
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: headers,
      ),
    );
    CertificatePinner.applyIfEnabled(dio);
    return dio;
  }

  /// Debug helper — prints SHA-256 pin for a host (run once during setup).
  static Future<String?> fetchPinForHost(String host, {int port = 443}) async {
    if (kIsWeb) return null;
    try {
      final socket = await SecureSocket.connect(
        host,
        port,
        onBadCertificate: (cert) => true,
      );
      final cert = socket.peerCertificate;
      await socket.close();
      if (cert == null) return null;
      return CertificatePinner.fingerprintSha256Hex(cert);
    } catch (_) {
      return null;
    }
  }
}
