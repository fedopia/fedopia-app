import 'dart:convert';
import 'dart:developer';

import 'package:fedopia/features/auth/data/constants/auth_vault_constants.dart';
import 'package:fedopia/features/auth/data/entities/account_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AccountVault {
  static const secureStorage = FlutterSecureStorage();

  static void addListener(Future<void> Function(Box) onChanged) async {
    final vault = await openVault();
    final listener = vault.listenable();
    listener.addListener(() async {
      onChanged(listener.value);
    });
  }

  /// Creates a new encryption key and saves it to secure storage
  /// @return true if successful
  /// @return false otherwise
  static Future<bool> createEncryptionKey() async {
    try {
      final newKey = Hive.generateSecureKey();
      await secureStorage.write(
        key: AuthVaultConstants.accountVaultEncryptionKey,
        value: base64UrlEncode(newKey),
      );
    } catch (e) {
      log(e.toString());
      return false;
    }

    return true;
  }

  /// Returns the encryption key from secure storage
  static Future<Uint8List> getEncryptionKey() async {
    log("Getting vault key");
    final encryptionKeyFromSecureStorage = await secureStorage.read(
      key: AuthVaultConstants.accountVaultEncryptionKey,
    );
    if (encryptionKeyFromSecureStorage == null) {
      final created = await createEncryptionKey();
      if (!created) {
        throw Exception("Failed to create encryption key");
      }
      return getEncryptionKey();
    }
    return base64Url.decode(encryptionKeyFromSecureStorage);
  }

  /// Opens the vault with the saved encryption key
  static Future<Box> openVault() async {
    log("Opening vault");
    await Hive.initFlutter();
    final encryptionKey = await getEncryptionKey();
    final vault = await Hive.openBox(
      AuthVaultConstants.accountVaultName,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
    return vault;
  }

  /// Adds the given account to the vault
  /// Returns saved account
  static Future<AccountEntity?> addAccount(AccountEntity account) async {
    final vault = await openVault();

    if (vault.containsKey(account.id)) {
      // Account already exists
      // maybe throw an error?
      return null;
    }

    await vault.put(account.id, account.toJson());
    return AccountEntity.fromJson(vault.get(account.id));
  }

  /// Get [AccountEntity]
  /// Returns the data if successful
  /// Returns null otherwise
  static Future<AccountEntity?> getAccount(String key) async {
    final vault = await openVault();
    final value = vault.get(key);
    if (value == null) {
      return null;
    }
    return AccountEntity.fromJson(value);
  }

  /// Deletes the account from the vault
  /// Returns true if successful
  /// Returns false otherwise
  static Future<bool> deleteAccount(String key) async {
    final vault = await openVault();
    try {
      vault.delete(key);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// Get a list of [AccountEntity]s
  /// @return account list
  static Future<List<AccountEntity>> getAccounts() async {
    final vault = await openVault();
    return vault.values
        .map((e) => AccountEntity.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
