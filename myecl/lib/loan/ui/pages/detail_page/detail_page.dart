import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loan = ref.watch(loanProvider);
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    return loan.when(
      data: (l) {
        return Stack(
          children: [
            Column(children: [
              Expanded(
                child: Container(
                  color: Colors.grey[50],
                ),
              ),
              Expanded(
                child: Container(
                  color: ColorConstant.darkGrey,
                ),
              ),
            ]),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: ColorConstant.darkGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            children: [
                              Text(
                                l.association,
                                style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstant.veryLightOrange),
                              ),
                              Text(
                                l.borrowerId,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstant.orange),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: Text(
                              l.items
                                      .fold(0, (a, b) => (a as int) + b.caution)
                                      .toString() +
                                  '€',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstant.veryLightOrange),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        processDate(l.start) + ' - ' + processDate(l.end),
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.veryLightOrange),
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    ...l.items
                        .map(
                          (e) => Container(
                            margin: const EdgeInsets.only(
                                bottom: 20, left: 25, right: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text("-",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.lightOrange)),
                                    const SizedBox(width: 20),
                                    Text(
                                      e.name,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: ColorConstant.lightOrange),
                                    ),
                                  ],
                                ),
                                Text(
                                  e.caution.toString() + '€',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstant.lightOrange),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    const SizedBox(
                      height: 70,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 25, right: 25),
                      child: Text(
                        l.notes,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.veryLightOrange),
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    GestureDetector(
                      onTap: () {
                        pageNotifier.setLoanPage(LoanPage.edit);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 50, right: 50),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              ColorConstant.orange,
                              ColorConstant.lightOrange,
                              ColorConstant.orange,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Modifier',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.lightGrey),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) {
        return Text(error.toString());
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ColorConstant.darkGrey),
          ),
        );
      },
    );
  }
}
