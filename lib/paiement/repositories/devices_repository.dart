import 'package:myecl/paiement/class/create_device.dart';
import 'package:myecl/paiement/class/wallet_device.dart';
import 'package:myecl/tools/repository/repository.dart';

class DevicesRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/users/me/wallet/devices';

  DevicesRepository(super.ref);

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
