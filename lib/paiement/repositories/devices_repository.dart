import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myemapp/auth/providers/openid_provider.dart';
import 'package:myemapp/paiement/class/create_device.dart';
import 'package:myemapp/paiement/class/wallet_device.dart';
import 'package:myemapp/tools/repository/repository.dart';

class DevicesRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myemapppay/users/me/wallet/devices';

  Future<WalletDevice> registerDevice(CreateDevice body) async {
    return WalletDevice.fromJson(await create(body.toJson()));
  }

  Future<List<WalletDevice>> getDevices() async {
    return List<WalletDevice>.from(
      (await getList()).map((e) => WalletDevice.fromJson(e)),
    );
  }

  Future<WalletDevice> getDevice(String id) async {
    return WalletDevice.fromJson(await getOne("", suffix: "/$id"));
  }

  Future<bool> revokeDevice(String id) async {
    return await create(id, suffix: '/$id/revoke');
  }
}

final devicesRepositoryProvider = Provider<DevicesRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return DevicesRepository()..setToken(token);
});
