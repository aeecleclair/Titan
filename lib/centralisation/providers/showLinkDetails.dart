import 'package:myecl/centralisation/class/module.dart';
import 'package:flutter/material.dart';
import 'package:myecl/centralisation/providers/openLink.dart';

void showLinkDetails(BuildContext context, Module module) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(module.name),
        content: Text(module.description),
        actions: [
          TextButton(
            child: Text('Accéder au site'),
            onPressed: () {
              openLink(module.url);
            },
          ),
          TextButton(
            child: Text('Fermer'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}