import 'package:flutter/material.dart';
import 'package:myecl/ph/ui/pages/past_ph_selection_page/ph_list.dart';
import 'package:myecl/ph/ui/pages/ph.dart';

class PastPhSelectionPage extends StatelessWidget {
  const PastPhSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PhTemplate(
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.sizeOf(context).height - 224,
              child: const SingleChildScrollView(child: PhList())),
        ],
      ),
    );
  }
}
