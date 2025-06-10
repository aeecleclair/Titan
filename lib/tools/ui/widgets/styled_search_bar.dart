import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class StyledSearchBar extends HookConsumerWidget {
  final Future Function(String)? onChanged;
  final String label;
  final Widget? suffixIcon;
  final Color color;
  final EdgeInsetsGeometry? padding;
  final void Function(FocusNode focusNode, TextEditingController controller)?
  onSuffixIconTap;
  final TextEditingController? editingController;
  const StyledSearchBar({
    super.key,
    this.onChanged,
    required this.label,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.padding,
    this.color = Colors.grey,
    this.editingController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final editingController =
        this.editingController ?? useTextEditingController();
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 30),
      alignment: Alignment.centerLeft,
      child: TextField(
        focusNode: focusNode,
        onChanged: (_) {
          tokenExpireWrapper(ref, () async {
            await onChanged?.call(editingController.text);
          });
        },
        controller: editingController,
        cursorColor: color,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          suffixIcon: onSuffixIconTap == null
              ? suffixIcon ?? Icon(Icons.search, color: color, size: 30)
              : GestureDetector(
                  onTap: () {
                    onSuffixIconTap!(focusNode, editingController);
                  },
                  child:
                      suffixIcon ?? Icon(Icons.search, color: color, size: 30),
                ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: color),
          ),
        ),
      ),
    );
  }
}
