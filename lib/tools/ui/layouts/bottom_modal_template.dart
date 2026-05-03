import 'package:flutter/material.dart';

enum BottomModalType { main, danger }

class BottomModalTemplate extends StatelessWidget {
  final Widget child;
  final String title;
  final String? description;
  final List<Widget>? actions;
  final BottomModalType type;
  final String? animationKey;

  const BottomModalTemplate({
    super.key,
    required this.child,
    this.type = BottomModalType.main,
    this.animationKey,
    required this.title,
    this.description,
    this.actions,
  });

  const BottomModalTemplate.danger({
    super.key,
    required this.child,
    this.animationKey,
    required this.title,
    this.description,
    this.actions,
  }) : type = BottomModalType.danger;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            width: 120,
            height: 4,
            decoration: BoxDecoration(
              color: Color(0xFF212121),
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF212121).withAlpha(50),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
        Hero(
          tag: animationKey ?? 'bottom_modal',
          child: Container(
            decoration: BoxDecoration(
              color: type == BottomModalType.main
                  ? Color(0xFFffffff)
                  : Color(0xFFfb6d10),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: type == BottomModalType.main
                        ? Color(0xFF424242)
                        : Color(0xFFffffff),
                  ),
                ),
                SizedBox(height: 20),
                if (description != null)
                  Text(
                    description!,
                    style: TextStyle(
                      fontSize: 15,
                      color: type == BottomModalType.main
                          ? Color(0xFF424242)
                          : Color(0xFFffffff),
                    ),
                  ),
                child,
                if (actions != null && actions!.isNotEmpty)
                  Column(children: actions!),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Future showCustomBottomModal({
  required BuildContext context,
  required Widget modal,
  Function? onCloseCallback,
}) async {
  await showModalBottomSheet(
    elevation: 3,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useRootNavigator: true,
    context: context,
    builder: (_) => modal,
  );
}
