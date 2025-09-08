import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:titan/ph/ui/pages/past_ph_selection_page/ph_list.dart';
import 'package:titan/ph/ui/pages/ph.dart';

class PastPhSelectionPage extends StatelessWidget {
  const PastPhSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PhTemplate(
      child: Padding(padding: EdgeInsets.all(8.0), child: PhList()),
    );
  }
}
