import 'package:flutter/material.dart';
import 'package:myecl/ph/ui/components/year_bar.dart';
import 'package:myecl/ph/ui/pages/past_ph_selection_page/ph_list.dart';
import 'package:myecl/ph/ui/pages/ph.dart';

class PastPhSelectionPage extends StatelessWidget {
  const PastPhSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PhTemplate(
      child: Column(
        children: [
          Column(
            children: [
              YearBar(),
              SingleChildScrollView(child: PhList()),
            ],
          ),
        ],
      ),
    );
  }
}
