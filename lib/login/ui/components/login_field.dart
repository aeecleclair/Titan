import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/login/tools/constants.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';

class CreateAccountField extends HookConsumerWidget {
  final TextEditingController controller;
  final String label;
  final int index;
  final PageController pageController;
  final ValueNotifier<int> currentPage;
  final TextInputType keyboardType;
  final List<String> autofillHints;
  final String hint;
  final GlobalKey<FormState> formKey;
  final bool canBeEmpty;
  final bool isPassword;
  final bool mustBeInt;
  final String? Function(String?)? validator;
  const CreateAccountField({
    super.key,
    required this.controller,
    required this.label,
    required this.index,
    required this.pageController,
    required this.currentPage,
    required this.formKey,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.autofillHints = const [],
    this.hint = '',
    this.canBeEmpty = false,
    this.mustBeInt = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPassword = keyboardType == TextInputType.visiblePassword;
    final hidePassword = useState(isPassword);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AlignLeftText(
          label,
          fontSize: 20,
          color: ColorConstants.background2,
        ),
        const SizedBox(height: 12),
        AutofillGroup(
            child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: TextFormField(
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            keyboardType: keyboardType,
            autofillHints: autofillHints,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(FocusNode());
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate);
              currentPage.value = index;
            },
            obscureText: hidePassword.value,
            controller: controller,
            cursorColor: Colors.white,
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                suffixIcon: (keyboardType == TextInputType.visiblePassword)
                    ? IconButton(
                        icon: Icon(
                          hidePassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          hidePassword.value = !hidePassword.value;
                        },
                      )
                    : null,
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorConstants.background2)),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.white,
                )),
                errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.white,
                )),
                errorStyle: const TextStyle(color: Colors.white)),
            validator: (value) {
              if (canBeEmpty) {
                return null;
              }
              if (value == null || value.isEmpty) {
                return LoginTextConstants.emptyFieldError;
              } else if (isPassword && (value != null && value.length < 6)) {
                return LoginTextConstants.passwordLengthError;
              } 
              if (mustBeInt && int.tryParse(value) == null) {
                return LoginTextConstants.mustBeIntError;
              }
              return validator?.call(value);
            },
          ),
        )),
      ],
    );
  }
}
