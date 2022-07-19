import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/repositories/loan_repository.dart';

class LoanListNotifier extends StateNotifier<AsyncValue<List<Loan>>> {
  final LoanRepository _repository = LoanRepository();
  LoanListNotifier() : super(const AsyncValue.loading());

  Future<AsyncValue<List<Loan>>> loadLoanList() async {
    try {
      // final loans = await _repository.getLoanList();
      final loans = [Loan(
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
      ),
      Loan(
        id: '2',
        borrowerId: '2',
        notes: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        start: DateTime(2020, 1, 1),
        end: DateTime(2020, 1, 31),
        association: 'Asso 1',
        caution: false,
        items: [
          Item(
            id: '3',
            name: 'Item 3',
            caution: 20,
            expiration: DateTime(2020, 1, 31),
            groupId: '',
          ),
        ],
      ),
      Loan(
        id: '3',
        borrowerId: '3',
        notes: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        start: DateTime(2020, 1, 1),
        end: DateTime(2020, 1, 31),
        association: 'Asso 2',
        caution: true,
        items: [
          Item(
            id: '4',
            name: 'Item 4',
            caution: 20,
            expiration: DateTime(2020, 1, 31),
            groupId: '',
          ),
          Item(
            id: '5',
            name: 'Item 5',
            caution: 80,
            expiration: DateTime(2020, 1, 31),
            groupId: '',
          ),
        ],
      ),
      Loan(
        id: '4',
        borrowerId: '4',
        notes: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        start: DateTime(2020, 1, 1),
        end: DateTime(2020, 1, 31),
        association: 'Asso 3',
        caution: false,
        items: [
          Item(
            id: '6',
            name: 'Item 6',
            caution: 20,
            expiration: DateTime(2020, 1, 31),
            groupId: '',
          ),
        ],
      ),
      Loan(
        id: '5',
        borrowerId: '5',
        notes: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        start: DateTime(2020, 1, 1),
        end: DateTime(2020, 1, 31),
        association: 'Asso 4',
        caution: true,
        items: [
          Item(
            id: '7',
            name: 'Item 7',
            caution: 20,
            expiration: DateTime(2020, 1, 31),
            groupId: '',
          ),
          Item(
            id: '8',
            name: 'Item 8',
            caution: 80,
            expiration: DateTime(2020, 1, 31),
            groupId: '',
          ),
        ],
      )
    ];
      state = AsyncValue.data(loans);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<bool> addLoan(Loan loan) async {
    return state.when(
      data: (loans) async {
        try {
          // await _repository.createLoan(loan);
          loans.add(loan);
          state = AsyncValue.data(loans);
          return true;
        } catch (e) {
          state = AsyncValue.data(loans);
          return false;
        }
      },
      error: (error, s) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        state = const AsyncValue.error("Cannot add loan while loading");
        return false;
      },
    );
  }

  Future<bool> updateLoan(Loan loan) async {
    return state.when(
      data: (loans) async {
        try {
          // await _repository.updateLoan(loan);
          var index = loans.indexWhere((element) => element.id == loan.id);
          loans[index] = loan;
          state = AsyncValue.data(loans);
          return true;
        } catch (e) {
          state = AsyncValue.data(loans);
          return false;
        }
      },
      error: (error, s) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        state = const AsyncValue.error("Cannot update loan while loading");
        return false;
      },
    );
  }

  Future<bool> deleteLoan(Loan loan) async {
    return state.when(
      data: (loans) async {
        try {
          // await _repository.deleteLoan(loan);
          loans.remove(loan);
          state = AsyncValue.data(loans);
          return true;
        } catch (e) {
          state = AsyncValue.data(loans);
          return false;
        }
      },
      error: (error, s) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        state = const AsyncValue.error("Cannot delete loan while loading");
        return false;
      },
    );
  }
}

final loanListProvider =
    StateNotifierProvider<LoanListNotifier, AsyncValue<List<Loan>>>((ref) {
  LoanListNotifier _loanListNotifier = LoanListNotifier();
  _loanListNotifier.loadLoanList();
  return _loanListNotifier;
});
