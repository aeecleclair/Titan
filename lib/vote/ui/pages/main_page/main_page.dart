import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/providers/pretendance_provider.dart';
import 'package:myecl/vote/providers/section_provider.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/pages/main_page/pretendance_card.dart';
import 'package:myecl/vote/ui/pages/main_page/side_item.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sections = ref.watch(sectionProvider);
    final pretendances = ref.watch(pretendanceProvider);
    return Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(VoteTextConstants.vote,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: sections.when(
              data: (sectionList) => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: sectionList
                          .map(
                            (e) => SideItem(
                              section: e,
                              isSelected: sectionList.first == e,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: pretendances.when(
                        data: (pretendanceList) => ListView.builder(
                          itemCount: pretendanceList.length,
                          itemBuilder: (context, index) {
                            return PretendanceCard(
                                pretendance: pretendanceList[index],
                                isCurrent: index == 0,
                                isSelected: index == 1);
                          },
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (error, stack) => const Center(
                          child: Text('Error'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => const Center(child: Text('Error')),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ]));
  }
}
