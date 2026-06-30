import 'package:flutter/services.dart';

/// Copies sensitive text and auto-clears clipboard after a short delay.
class SecureClipboardService {
  SecureClipboardService({this.clearAfter = const Duration(seconds: 30)});

  final Duration clearAfter;

  Future<void> copySensitive(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    Future<void>.delayed(clearAfter, () async {
      final current = await Clipboard.getData(Clipboard.kTextPlain);
      if (current?.text == text) {
        await Clipboard.setData(const ClipboardData(text: ''));
      }
    });
  }

  Future<void> clear() => Clipboard.setData(const ClipboardData(text: ''));
}
