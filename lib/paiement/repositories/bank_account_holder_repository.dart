import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/paiement/class/bank_account_holder.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/tools/repository/repository.dart';

class BankAccountHolderRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'mypayment/bank-account-holder';

  Future<BankAccountHolder> getBankAccountHolder() async {
    try {
      return BankAccountHolder.fromJson(await getOne(""));
    } on AppException catch (e) {
      if (e.type == ErrorType.tokenExpire) rethrow;
      return BankAccountHolder.empty();
    } catch (e) {
      return BankAccountHolder.empty();
    }
  }

  Future<BankAccountHolder> updateBankAccountHolder(String structureId) async {
    return BankAccountHolder.fromJson(
      await create({'holder_structure_id': structureId}),
    );
  }
}

final bankAccountHolderRepositoryProvider =
    Provider<BankAccountHolderRepository>((ref) {
      final token = ref.watch(tokenProvider);
      return BankAccountHolderRepository()..setToken(token);
    });
