import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:myecl/ph/ui/button.dart';
import 'package:myecl/ph/ui/pages/add_ph_page/add_page.dart';
import 'package:myecl/ph/ui/pages/admin_page/ph_list.dart';
import 'package:myecl/ph/ui/pages/ph.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PhTemplate(
      child: Column(
        children: [
          PdfPicker(),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
