import 'package:titan/centralisation/class/module.dart';
import 'package:flutter/material.dart';
import 'package:titan/centralisation/tools/constants.dart';
import 'package:url_launcher/url_launcher.dart';

void showLinkDetails(BuildContext context, Module module) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(module.name),
        content: Text(module.description),
        actions: [
          TextButton(
            child: const Text(CentralisationTextConstants.openLink),
            onPressed: () {
              openLink(module.url);
            },
          ),
          TextButton(
            child: const Text(CentralisationTextConstants.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void openLink(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    throw '${CentralisationTextConstants.unableToOpen} $url';
  }
}
