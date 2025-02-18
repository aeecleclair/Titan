import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/ui/pages/stats_page/sum_up_card.dart';

class SumUpChart extends HookConsumerWidget {
  const SumUpChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState(-1);

    List<PieChartSectionData> showingSections() {
      return [
        PieChartSectionData(
            value: 10,
            radius: 60 + (selected.value == 0 ? 15 : 0),
            title: "",
            color: const Color.fromARGB(255, 255, 119, 7),
            badgeWidget: SumUpCard(
              amount: '34,23€',
              color: const Color.fromARGB(255, 255, 119, 7),
              darkColor: const Color.fromARGB(255, 230, 103, 0),
              shadowColor: const Color.fromARGB(255, 97, 44, 0).withOpacity(0.2),
              title: 'Bar',
            )),
        PieChartSectionData(
          value: 25,
          color: const Color(0xff017f80),
          radius: 70 + (selected.value == 1 ? 15 : 0),
          title: "",
          badgeWidget:  SumUpCard(
            amount: '170,23€',
            color: const Color.fromARGB(255, 1, 127, 128),
            darkColor: const Color.fromARGB(255, 0, 102, 103),
            shadowColor: const Color.fromARGB(255, 0, 44, 45).withOpacity(0.3),
            title: 'WEI',
          ),
        ),
        PieChartSectionData(
          value: 15,
          color: const Color.fromARGB(255, 4, 84, 84),
          title: "",
          radius: 65 + (selected.value == 2 ? 15 : 0),
          badgeWidget:  SumUpCard(
            amount: '90,23€',
            color: const Color.fromARGB(255, 4, 84, 84),
            darkColor: const Color.fromARGB(255, 0, 68, 68),
            shadowColor: const Color.fromARGB(255, 0, 29, 29).withOpacity(0.4),
            title: 'BE',
          ),
        ),
      ];
    }

    return Expanded(
      child: Stack(
        children: [
          PieChart(
            PieChartData(
                borderData: FlBorderData(
                  show: true,
                ),
                pieTouchData: PieTouchData(
                    touchCallback: (flTouchEvent, pieTouchResponse) {
                  selected.value =
                      pieTouchResponse?.touchedSection?.touchedSectionIndex ??
                          0;
                }),
                sectionsSpace: 8,
                centerSpaceRadius: 80,
                sections: showingSections()),
            swapAnimationCurve: Curves.easeOutCubic,
          ),
          const SizedBox(
            height: 300,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "348,23€",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 4, 84, 84)),
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
