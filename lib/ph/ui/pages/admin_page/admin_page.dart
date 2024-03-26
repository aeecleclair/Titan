import 'package:flutter/material.dart';
import 'package:myecl/ph/ui/pages/admin_page/ph_list.dart';
import 'package:myecl/ph/ui/pages/ph.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PhTemplate(child: PhList());
  }
}
