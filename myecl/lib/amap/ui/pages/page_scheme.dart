import 'package:flutter/material.dart';
import 'package:myecl/amap/ui/main_page_btn.dart';

/// La page des commandes
class PageScheme extends StatelessWidget {
  final Widget subPage;
  const PageScheme({Key? key, required this.subPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        const MainPageBtn(),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height - 240,
            child: subPage
        ),
      ],
    );
  }
}
