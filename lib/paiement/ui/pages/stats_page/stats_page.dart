import 'package:flutter/material.dart';
import 'package:myecl/paiement/ui/pages/stats_page/month_bar.dart';
import 'package:myecl/paiement/ui/pages/stats_page/sum_up_chart.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          MonthBar(),
          SizedBox(
            height:50,
          ),
          SumUpChart(),
          Spacer(),
        ],
      ),
    );
  }
}
