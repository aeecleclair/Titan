import 'package:flutter/material.dart';

class EmailChangeDialog extends StatelessWidget {
  const EmailChangeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black)),
                color: Colors.white,
              ),
              child: const Text("Changer d'adresse mail", style: TextStyle(fontSize: 20)))),
      content: const SizedBox(
          height: 100,
          child: Column(
            children: [
              SizedBox(height: 25),
              Text("Nouvelle adresse mail :"),
              SizedBox(height: 5),
              SizedBox(
                width: 200,
                child: TextField(
                  // controller: controller,
                ),
              )
            ],
          )),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Plus tard"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            // onConfirm();
          },
          child: const Text("Confirmer"),
        ),
      ],
    );
  }

}