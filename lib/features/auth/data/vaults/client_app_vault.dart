import 'dart:convert';
import 'dart:developer';

import 'package:fedopia/features/auth/data/constants/auth_vault_constants.dart';
import 'package:fedopia/features/auth/data/entities/client_app_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ClientAppVault {
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
        key: AuthVaultConstants.clientAppVaultEncryptionKey,
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
      key: AuthVaultConstants.clientAppVaultEncryptionKey,
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
      AuthVaultConstants.clientAppVaultName,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
    return vault;
  }

  /// Adds the given clientApp to the vault
  /// Returns saved clientApp
  static Future<ClientAppEntity?> addClientApp(
      ClientAppEntity clientApp) async {
    final vault = await openVault();

    if (vault.containsKey(clientApp.redirectUri)) {
      // ClientApp already exists
      // maybe throw an error?
      return null;
    }

    await vault.put(clientApp.redirectUri, clientApp.toJson());
    return ClientAppEntity.fromJson(vault.get(clientApp.redirectUri));
  }

  /// Get [ClientAppEntity]
  /// Returns the data if successful
  /// Returns null otherwise
  static Future<ClientAppEntity?> getClientApp(String key) async {
    final vault = await openVault();
    final value = vault.get(key);
    if (value == null) {
      return null;
    }
    return ClientAppEntity.fromJson(Map<String, dynamic>.from(value));
  }

  /// Deletes the clientApp from the vault
  /// Returns true if successful
  /// Returns false otherwise
  static Future<bool> deleteClientApp(String key) async {
    final vault = await openVault();
    try {
      vault.delete(key);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// Get a list of [ClientAppEntity]s
  /// @return clientApp list
  static Future<List<ClientAppEntity>> getClientApps() async {
    final vault = await openVault();
    return vault.values
        .map((e) => ClientAppEntity.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
