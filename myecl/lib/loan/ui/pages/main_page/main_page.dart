import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/loan_ui.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    AsyncValue<List<Loan>> fake_data = AsyncValue.data([
      Loan(
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
    ]);
    List<Widget> listWidget = [
      Container(
          margin: const EdgeInsets.only(right: 10, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "En cours",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      pageNotifier.setLoanPage(LoanPage.history);
                    },
                    icon: const HeroIcon(
                      HeroIcons.clipboardList,
                      color: ColorConstant.lightGrey,
                      size: 25,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      pageNotifier.setLoanPage(LoanPage.option);
                    },
                    icon: const HeroIcon(
                      HeroIcons.plus,
                      color: ColorConstant.lightGrey,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ],
          ))
    ];

    fake_data.when(
      data: (data) {
        List<String> categories =
            data.map((e) => e.association).toSet().toList();
        Map<String, List<Widget>> dictCateListWidget = {
          for (var item in categories) item: []
        };

        for (Loan l in data) {
          dictCateListWidget[l.association]!.add(LoanUi(l: l));
        }

        for (String c in categories) {
          listWidget.add(Container(
              height: 50,
              alignment: Alignment.centerLeft,
              child: Container(
                height: 40,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  c,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )));

          listWidget += dictCateListWidget[c] ?? [];
        }
      },
      loading: () {
        listWidget.add(const Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(ColorConstant.darkGrey),
        )));
      },
      error: (error, s) {
        listWidget.add(const Center(child: Text('Error')));
      },
    );

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          ...listWidget,
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
