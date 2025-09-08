import 'dart:convert';
import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KeyService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      // A service name is required for iOS KeyChain
      accountName: 'fr.titan.myecl',
    ),
  );
  final algorithm = Ed25519();

  Future<SimpleKeyPair> generateKeyPair() async {
    return await algorithm.newKeyPair();
  }

  Future saveKeyPair(SimpleKeyPair keyPair) async {
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

  Future saveKeyId(String keyId) async {
    await _secureStorage.write(key: 'keyId', value: keyId);
  }

  Future<SimpleKeyPair?> getKeyPair() async {
    final privateKeyString = await _secureStorage.read(key: 'privateKey');
    final publicKeyString = await _secureStorage.read(key: 'publicKey');
    if (privateKeyString == null || publicKeyString == null) {
      return null;
    }
    final migrated = await _secureStorage.read(key: 'migrated');
    if (migrated == null) {
      final privateKey = privateKeyString.codeUnits;
      final publicKey = publicKeyString.codeUnits;

      await _secureStorage.write(
        key: 'privateKey',
        value: base64.encode(privateKey),
      );
      await _secureStorage.write(
        key: 'publicKey',
        value: base64.encode(publicKey),
      );
      await _secureStorage.write(key: 'migrated', value: 'true');
      return SimpleKeyPairData(
        privateKey,
        publicKey: SimplePublicKey(publicKey, type: KeyPairType.ed25519),
        type: KeyPairType.ed25519,
      );
    }
    final privateKey = base64.decode(privateKeyString);
    final publicKey = base64.decode(publicKeyString);
    return SimpleKeyPairData(
      privateKey,
      publicKey: SimplePublicKey(publicKey, type: KeyPairType.ed25519),
      type: KeyPairType.ed25519,
    );
  }

  Future<String?> getKeyId() async {
    return await _secureStorage.read(key: "keyId");
  }

  Future<bool> clear() async {
    await _secureStorage.delete(key: 'privateKey');
    await _secureStorage.delete(key: 'publicKey');
    await _secureStorage.delete(key: 'keyId');
    return true;
  }

  Future<Signature> signMessage(
    SimpleKeyPair keyPair,
    List<int> message,
  ) async {
    return await algorithm.sign(message, keyPair: keyPair);
  }
}
