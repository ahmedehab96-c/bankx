import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../storage/secure_storage_service.dart';
import 'secure_storage_keys.dart';

/// PIN lock with salted SHA-256 hash stored in secure storage.
class PinLockService {
  PinLockService(this._secureStorage);

  final SecureStorageService _secureStorage;

  Future<bool> isPinSet() async {
    final hash = await _secureStorage.read(SecurityStorageKeys.pinHash);
    return hash != null && hash.isNotEmpty;
  }

  Future<void> setPin(String pin) async {
    final salt = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = _hashPin(pin, salt);
    await _secureStorage.write(SecurityStorageKeys.pinSalt, salt);
    await _secureStorage.write(SecurityStorageKeys.pinHash, hash);
  }

  Future<bool> verifyPin(String pin) async {
    final storedHash = await _secureStorage.read(SecurityStorageKeys.pinHash);
    final salt = await _secureStorage.read(SecurityStorageKeys.pinSalt);
    if (storedHash == null || salt == null) return false;
    return storedHash == _hashPin(pin, salt);
  }

  Future<void> clearPin() async {
    await _secureStorage.delete(SecurityStorageKeys.pinHash);
    await _secureStorage.delete(SecurityStorageKeys.pinSalt);
  }

  String _hashPin(String pin, String salt) {
    final bytes = utf8.encode('$salt:$pin');
    return sha256.convert(bytes).toString();
  }
}
