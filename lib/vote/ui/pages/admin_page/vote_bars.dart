import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/vote/providers/result_provider.dart';
import 'package:titan/vote/providers/sections_contender_provider.dart';
import 'package:titan/vote/providers/sections_provider.dart';
import 'package:titan/vote/tools/constants.dart';

class VoteBars extends HookConsumerWidget {
  const VoteBars({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const Duration animDuration = Duration(milliseconds: 250);
    final sectionsContender = ref.watch(sectionContenderProvider);
    final section = ref.watch(sectionProvider);
    final results = ref.watch(resultProvider);
    final touchedIndex = useState(-1);
    final isTouched = useState(false);
    final barBackgroundColor = Colors.grey.shade300;
    const barColor = Colors.black;

    List<BarChartGroupData> contenderBars = [];
    List<String> sectionNames = [];
    Map<String, int> voteValue = {};
    results.whenData((votes) {
      for (var i = 0; i < votes.length; i++) {
        voteValue[votes[i].id] = votes[i].count;
      }
    });

    final Map<int, String> sectionIds = {};
    int total = 0;

    if (sectionsContender[section] != null) {
      sectionsContender[section]!.maybeWhen(
        data: ((data) {
          sectionNames = data.map((e) => e.name).toList();
          sectionIds.addAll({for (var e in data) data.indexOf(e): e.id});
          total =
              data
                  .map((e) => voteValue[e.id])
                  .reduce((value, element) => (value ?? 0) + (element ?? 0)) ??
              0;
          contenderBars = data
              .map(
                (x) => BarChartGroupData(
                  x: data.indexOf(x),
                  barRods: [
                    BarChartRodData(
                      toY: (voteValue[sectionIds[data.indexOf(x)]] ?? 0)
                          .toDouble(),
                      color: isTouched.value ? Colors.grey.shade800 : barColor,
                      width: 40,
                      borderSide: isTouched.value
                          ? const BorderSide(color: Colors.white, width: 2)
                          : const BorderSide(color: Colors.white, width: 0),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        color: barBackgroundColor,
                      ),
                    ),
                  ],
                ),
              )
              .toList();
        }),
        orElse: () {},
      );
    }

    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        child: BarChart(
          BarChartData(
            gridData: const FlGridData(show: false),
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                tooltipBorderRadius: BorderRadius.circular(20),
                tooltipPadding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 12,
                  bottom: 5,
                ),
                tooltipMargin: 10,
                getTooltipColor: (BarChartGroupData group) =>
                    Colors.grey.shade200,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    rod.toY.toInt().toString(),
                    const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  );
                },
              ),
              touchCallback: (FlTouchEvent event, barTouchResponse) {
                if (!event.isInterestedForInteractions ||
                    barTouchResponse == null ||
                    barTouchResponse.spot == null) {
                  touchedIndex.value = -1;
                  return;
                }
                touchedIndex.value =
                    barTouchResponse.spot!.touchedBarGroupIndex;
              },
            ),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Column(
                        children: [
                          Text(
                            sectionNames[value.toInt()],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${((voteValue[sectionIds[value.toInt()]] ?? 0) / total * 100).toStringAsFixed(2)}%',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${voteValue[sectionIds[value.toInt()]] ?? 0} ${VoteTextConstants.votes}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  reservedSize: 75,
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            barGroups: contenderBars,
          ),
          duration: animDuration,
        ),
      ),
    );
  }
}
