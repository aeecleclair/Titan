import 'package:flutter/material.dart';
import 'package:myecl/paiement/ui/pages/stats_page/month_bar.dart';
import 'package:myecl/paiement/ui/pages/stats_page/sum_up_chart.dart';
import 'package:myecl/paiement/ui/paiement.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PaymentTemplate(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          MonthBar(),
          SizedBox(
            height: 50,
          ),
          SumUpChart(),
          Spacer(),
        ],
      ),
    );
  }
}
