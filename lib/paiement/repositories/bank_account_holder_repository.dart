import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/paiement/class/structure.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/tools/repository/repository.dart';

class BankAccountHolderRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'mypayment/bank-account-holder';

  Future<Structure> getBankAccountHolder() async {
    try {
      return Structure.fromJson(await getOne(""));
    } on AppException catch (e) {
      if (e.type == ErrorType.tokenExpire) rethrow;
      return Structure.empty();
    } catch (e) {
      return Structure.empty();
    }
  }

  Future<Structure> updateBankAccountHolder(Structure structure) async {
    return Structure.fromJson(
      await create({'holder_structure_id': structure.id}),
    );
  }
}

final bankAccountHolderRepositoryProvider =
    Provider<BankAccountHolderRepository>((ref) {
      final token = ref.watch(tokenProvider);
      return BankAccountHolderRepository()..setToken(token);
    });
