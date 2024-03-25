import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/class/ph_admin.dart';
import 'package:myecl/ph/repositories/ph_admin_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class PhAdminListNotifier extends ListNotifier<PhAdmin> {
  final PhAdminRepository phAdminRepository;
  PhAdminListNotifier({required this.phAdminRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<PhAdmin>>> loadPhAdminList() async {
    return await loadList(phAdminRepository.getPhAdminList);
  }

  Future<bool> addPhAdmin(PhAdmin phAdmin) async {
    return await add(phAdminRepository.createPhAdmin, phAdmin);
  }

  Future<bool> updatePhAdmin(PhAdmin phAdmin) async {
    return await update(
        phAdminRepository.updatePhAdmin,
        (phAdmins, phAdmin) => phAdmins
          ..[phAdmins.indexWhere((i) => i.id == phAdmin.id)] = phAdmin,
        phAdmin);
  }

  Future<bool> deletePhAdmin(PhAdmin phAdmin) async {
    return await delete(
        phAdminRepository.deletePhAdmin,
        (phs, ph) => phs..removeWhere((i) => i.id == ph.id),
        phAdmin.id,
        phAdmin);
  }
}

final phAdminListProvider =
    StateNotifierProvider<PhAdminListNotifier, AsyncValue<List<PhAdmin>>>(
  (ref) {
    final phAdminRepository = ref.watch(phAdminRepositoryProvider);
    PhAdminListNotifier orderListNotifier =
        PhAdminListNotifier(phAdminRepository: phAdminRepository);
    tokenExpireWrapperAuth(ref, () async {
      await orderListNotifier.loadPhAdminList();
    });
    return orderListNotifier;
  },
);
