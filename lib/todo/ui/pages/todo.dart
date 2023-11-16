import 'package:flutter/material.dart';
import 'package:myecl/todo/tools/constants.dart';
import 'package:myecl/todo/ui/router.dart';
import 'package:myecl/tools/ui/top_bar.dart';

class TodoTemplate extends StatelessWidget {
  final Widget child;
  const TodoTemplate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const TopBar(
            title: TodoTextConstants.todo,
            root: TodoRouter.root,
          ),
          Expanded(child: child)
        ],
      ),
    );
  }
}
