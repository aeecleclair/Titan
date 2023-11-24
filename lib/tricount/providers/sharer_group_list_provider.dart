import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tricount/class/sharer_group.dart';
import 'package:myecl/tricount/class/transaction.dart';
import 'package:myecl/tricount/repositories/reimbursement_repository.dart';
import 'package:myecl/tricount/repositories/sharer_group_repository.dart';
import 'package:myecl/tricount/repositories/sharer_repository.dart';
import 'package:myecl/tricount/repositories/transaction_repository.dart';

class SharerGroupListNotifier extends ListNotifier<SharerGroup> {
  final SharerGroupRepository sharerGroupRepository = SharerGroupRepository();
  final SharerRepository sharerRepository = SharerRepository();
  final TransactionRepository transactionRepository = TransactionRepository();
  final ReimbursementRepository reimbursementRepository =
      ReimbursementRepository();
  SharerGroupListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    sharerGroupRepository.setToken(token);
    sharerRepository.setToken(token);
    transactionRepository.setToken(token);
    reimbursementRepository.setToken(token);
  }

  Future<AsyncValue<List<SharerGroup>>> loadSharerGroupList() async {
    return await loadList(sharerGroupRepository.getSharerGroupList);
  }

  Future<bool> addSharerGroup(SharerGroup sharerGroup) async {
    return await add(sharerGroupRepository.createSharerGroup, sharerGroup);
  }

  Future<bool> updateSharerGroup(SharerGroup sharerGroup) async {
    return await update(
        sharerGroupRepository.updateSharerGroup,
        (sharerGroups, sharerGroup) => sharerGroups
          ..[sharerGroups.indexWhere((i) => i.id == sharerGroup.id)] =
              sharerGroup,
        sharerGroup);
  }

  Future<bool> addSharerToSharerGroup(
      SharerGroup sharerGroup, String sharerId, bool retroPropagate) async {
    return await update(
        (sharerGroup) => sharerRepository.createSharer(
            sharerGroup.id, sharerId, retroPropagate),
        (sharerGroups, sharerGroup) => sharerGroups
          ..[sharerGroups.indexWhere((i) => i.id == sharerGroup.id)] =
              sharerGroup,
        sharerGroup);
  }

  Future<bool> deleteSharerFromSharerGroup(
      SharerGroup sharerGroup, String sharerId) async {
    return await update(
        (sharerGroup) =>
            sharerRepository.deleteSharer(sharerGroup.id, sharerId),
        (sharerGroups, sharerGroup) => sharerGroups
          ..[sharerGroups.indexWhere((i) => i.id == sharerGroup.id)] =
              sharerGroup,
        sharerGroup);
  }

  Future<bool> addTransactionToSharerGroup(
      SharerGroup sharerGroup, Transaction transaction) async {
    return await update(
        (sharerGroup) => transactionRepository.createTransaction(transaction),
        (sharerGroups, sharerGroup) => sharerGroups
          ..[sharerGroups.indexWhere((i) => i.id == sharerGroup.id)] =
              sharerGroup,
        sharerGroup);
  }

  Future<bool> deleteTransactionFromSharerGroup(
      SharerGroup sharerGroup, String transactionId) async {
    return await update(
        (sharerGroup) => transactionRepository.deleteTransaction(transactionId),
        (sharerGroups, sharerGroup) => sharerGroups
          ..[sharerGroups.indexWhere((i) => i.id == sharerGroup.id)] =
              sharerGroup,
        sharerGroup);
  }

  Future<bool> addReimbursementToSharerGroup(
      SharerGroup sharerGroup, String beneficiaryId, double? amount) async {
    return await updateWithItem(
        () => reimbursementRepository.reimburseInGroup(
            sharerGroup.id, beneficiaryId, amount),
        (sharerGroups, sharerGroup) => sharerGroups
          ..[sharerGroups.indexWhere((i) => i.id == sharerGroup.id)] =
              sharerGroup);
  }

  Future<AsyncValue<List<SharerGroup>>> reimburseUser(
      String beneficiaryId) async {
    return await loadList(
        () => reimbursementRepository.reimburseTotal(beneficiaryId));
  }
}

final sharerGroupListProvider = StateNotifierProvider<SharerGroupListNotifier,
    AsyncValue<List<SharerGroup>>>((ref) {
  final token = ref.watch(tokenProvider);
  final sharerGroupListNotifier = SharerGroupListNotifier(token: token);
  sharerGroupListNotifier.loadSharerGroupList();
  return sharerGroupListNotifier;
});
