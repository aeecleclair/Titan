import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SumUpChart extends HookConsumerWidget {
  const SumUpChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState(0);

    List<PieChartSectionData> showingSections() {
      return [
        PieChartSectionData(
          value: 10,
          color: const Color.fromARGB(255, 255, 119, 7),
          radius: 60 + (selected.value == 0 ? 15 : 0),
          title: "10%",
          titleStyle: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          // badgePositionPercentageOffset: 0,
          badgeWidget: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "10%",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 119, 7),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        PieChartSectionData(
          value: 25,
          color: const Color(0xff017f80),
          radius: 70 + (selected.value == 1 ? 15 : 0),
          titleStyle: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          // badgePositionPercentageOffset: 1.5,
          badgeWidget: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "10%",
                style: TextStyle(
                    color: Color(0xff017f80), fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        PieChartSectionData(
          value: 15,
          color: const Color.fromARGB(255, 4, 84, 84),
          titleStyle: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          // badgePositionPercentageOffset: 1.5,
          badgeWidget: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "10%",
                style: TextStyle(
                    color: Color.fromARGB(255, 4, 84, 84),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          radius: 65 + (selected.value == 2 ? 15 : 0),
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
          ),
          const SizedBox(
            height: 300,
            child:
                Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text(
                  "Total",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey),
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
