import 'dart:convert';

import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KeyService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      // If the Keystore-wrapped key referenced by the stored ciphertext no
      // longer exists on this device (typically after Auto Backup / a
      // device-transfer restore lands the file on a device that never held
      // the original key), the plugin wipes the corrupted preference file
      // natively instead of throwing on every subsequent call.
      resetOnError: true,
    ),
    iOptions: IOSOptions(accountName: 'fr.titan.myecl'),
  );
  final algorithm = Ed25519();

  Future<SimpleKeyPair> generateKeyPair() async {
    return await algorithm.newKeyPair();
  }

  Future<void> saveKeyPair(SimpleKeyPair keyPair) async {
    final privateKey = await keyPair.extractPrivateKeyBytes();
    final publicKey = await keyPair.extractPublicKey();
    await _secureStorage.write(
      key: 'privateKey',
      value: base64.encode(privateKey),
    );
    await _secureStorage.write(
      key: 'publicKey',
      value: base64.encode(publicKey.bytes),
    );
    await _secureStorage.write(key: 'migrated', value: 'true');
  }

  Future<void> saveKeyId(String keyId) async {
    await _secureStorage.write(key: 'keyId', value: keyId);
  }

  Future<SimpleKeyPair?> getKeyPair() async {
    try {
      final privateKeyString = await _secureStorage.read(key: 'privateKey');
      final publicKeyString = await _secureStorage.read(key: 'publicKey');
      if (privateKeyString == null || publicKeyString == null) {
        return null;
      }

      final migrated = await _secureStorage.read(key: 'migrated');
      List<int> privateKey;
      List<int> publicKey;
      if (migrated == null) {
        // Legacy (pre-base64) storage format from older app versions.
        privateKey = privateKeyString.codeUnits;
        publicKey = publicKeyString.codeUnits;
        await _secureStorage.write(
          key: 'privateKey',
          value: base64.encode(privateKey),
        );
        await _secureStorage.write(
          key: 'publicKey',
          value: base64.encode(publicKey),
        );
        await _secureStorage.write(key: 'migrated', value: 'true');
      } else {
        privateKey = base64.decode(privateKeyString);
        publicKey = base64.decode(publicKeyString);
      }

      return SimpleKeyPairData(
        privateKey,
        publicKey: SimplePublicKey(publicKey, type: KeyPairType.ed25519),
        type: KeyPairType.ed25519,
      );
    } catch (e) {
      // Ciphertext/format we can't decode: almost certainly leftover data
      // from another installation (Auto Backup, device transfer, a Keychain
      // holdover...). Don't let a half-broken identity linger - wipe it so
      // the UI reliably falls back to the "add device" flow instead of
      // looping on the same error forever.
      await clear();
      return null;
    }
  }

  Future<String?> getKeyId() async {
    try {
      return await _secureStorage.read(key: 'keyId');
    } catch (e) {
      await clear();
      return null;
    }
  }

  Future<bool> clear() async {
    // deleteAll() instead of deleting keys one by one: on Android this also
    // clears the corrupted internal keysets that a partial delete can leave
    // behind, and it can't silently forget a key that gets added later.
    await _secureStorage.deleteAll();
    return true;
  }

  Future<Signature> signMessage(
    SimpleKeyPair keyPair,
    List<int> message,
  ) async {
    return await algorithm.sign(message, keyPair: keyPair);
  }
}
