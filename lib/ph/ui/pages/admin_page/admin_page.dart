import 'package:flutter/material.dart';
import 'package:myecl/ph/ui/pages/ph.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PhTemplate(
        child: Column(
      children: [
        HorizontalListView.builder(
          height: 50,
          items: data,
        )
      ],
    ));
  }
}
