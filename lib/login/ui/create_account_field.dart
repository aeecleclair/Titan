import 'package:flutter/material.dart';
import 'package:myecl/login/tools/constants.dart';

class CreateAccountField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int index;
  final PageController pageController;
  final ValueNotifier<int> currentPage;
  const CreateAccountField(
      {super.key,
      required this.controller,
      required this.label,
      required this.index,
      required this.pageController,
      required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(label,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: LoginColorConstants.background,
              )),
        ),
        TextFormField(
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          onFieldSubmitted: (_) {
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.decelerate);
            currentPage.value = index;
          },
          controller: controller,
          cursorColor: Colors.white,
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: LoginColorConstants.background)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.white,
              )),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.white,
              )),
              errorStyle: TextStyle(color: Colors.white)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LoginTextConstants.emptyFieldError;
            }
            return null;
          },
        ),
      ],
    );
  }
}
