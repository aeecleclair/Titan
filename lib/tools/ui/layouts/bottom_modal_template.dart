import 'package:flutter/material.dart';

class BottomModalTemplate extends StatelessWidget {
  final String title;
  final String? description;
  final List<Widget> actions;
  final String? animationKey;

  const BottomModalTemplate({
    super.key,
    this.animationKey,
    required this.title,
    this.description,
    required this.actions,
  });

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
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
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
              color: Theme.of(context).colorScheme.surface,
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
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
                SizedBox(height: 20),
                if (description != null)
                  Text(
                    description!,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                  ),
                Column(children: actions),
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
