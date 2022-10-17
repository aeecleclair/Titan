import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/vote/providers/pretendance_provider.dart';
import 'package:myecl/vote/providers/section_provider.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/pages/main_page/pretendance_card.dart';
import 'package:myecl/vote/ui/pages/main_page/side_item.dart';
import 'package:myecl/vote/ui/refresh_indicator.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sections = ref.watch(sectionProvider);
    final pretendances = ref.watch(pretendanceProvider);
    final selectedSection = useState(0);
    final selectedPretendance = useState(-1);
    final currentPretendance = useState(-1);
    return VoteRefresher(
      onRefresh: () async {
        ref.refresh(sectionProvider);
        ref.refresh(pretendanceProvider);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: Padding(
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
                            children: sectionList.map((e) {
                              final index = sectionList.indexOf(e);
                              return SideItem(
                                section: e,
                                isSelected: index == selectedSection.value,
                                onTap: () {
                                  selectedSection.value = index;
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: pretendances.when(
                              data: (pretendanceList) => Column(children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 20),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      sectionList[selectedSection.value].name,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              Color.fromARGB(255, 1, 40, 72))),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: pretendanceList.map((e) {
                                        final index =
                                            pretendanceList.indexOf(e);
                                        return PretendanceCard(
                                            pretendance: pretendanceList[index],
                                            isCurrent: index ==
                                                currentPretendance.value,
                                            isSelected: index ==
                                                selectedPretendance.value,
                                            onTap: () {
                                              if (currentPretendance.value ==
                                                  index) {
                                                currentPretendance.value = -1;
                                              } else {
                                                currentPretendance.value =
                                                    index;
                                              }
                                            },
                                            onVote: () {
                                              selectedPretendance.value = index;
                                            });
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 30),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: selectedPretendance
                                                          .value !=
                                                      -1
                                                  ? const [
                                                      VoteColorConstants.green5,
                                                      Color.fromARGB(
                                                          255, 1, 40, 72),
                                                    ]
                                                  : const [
                                                      Color.fromARGB(
                                                          150, 32, 83, 116),
                                                      Color.fromARGB(
                                                          150, 1, 40, 72),
                                                    ]),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: const Center(
                                        child: Text(
                                          VoteTextConstants.vote,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
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
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => const Center(child: Text('Error')),
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}
