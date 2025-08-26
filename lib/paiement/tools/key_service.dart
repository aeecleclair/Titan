import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:titan/tools/functions.dart';

class KeyService {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(
      // A service name is required for iOS KeyChain
      accountName: getTitanPackageName(),
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
      value: String.fromCharCodes(privateKey),
    );
    await _secureStorage.write(
      key: 'publicKey',
      value: String.fromCharCodes(publicKey.bytes),
    );
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
    final privateKey = privateKeyString.codeUnits;
    final publicKey = publicKeyString.codeUnits;
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
