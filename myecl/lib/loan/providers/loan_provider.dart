import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/repositories/loan_repository.dart';

class LoanNotifier extends StateNotifier<AsyncValue<Loan>> {
  final LoanRepository _repository = LoanRepository();
  LoanNotifier() : super(const AsyncValue.loading());

  Future<AsyncValue<Loan>> loadLoan(String id) async {
    try {
      // final loan = await _repository.getLoan(id);
      final loan = Loan(
        id: '1',
        borrowerId: '1',
        notes: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        start: DateTime(2020, 1, 1),
        end: DateTime(2020, 1, 31),
        association: 'Asso 1',
        caution: true,
        items: [
          Item(
            id: '1',
            name: 'Item 1',
            caution: 20,
            expiration: DateTime(2020, 1, 31),
            groupId: '',
          ),
          Item(
            id: '2',
            name: 'Item 2',
            caution: 80,
            expiration: DateTime(2020, 1, 31),
            groupId: '',
          ),
        ],
      );
      state = AsyncValue.data(loan);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  void setLoan(Loan loan) {
    state = AsyncValue.data(loan);
  }
}

final loanProvider = StateNotifierProvider<LoanNotifier, AsyncValue<Loan>>(
    (ref) => LoanNotifier());
