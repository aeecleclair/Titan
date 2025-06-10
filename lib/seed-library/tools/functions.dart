import 'package:flutter/material.dart';
import 'package:titan/seed-library/tools/constants.dart';
import 'package:url_launcher/url_launcher.dart';

void openLink(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    throw '${SeedLibraryTextConstants.unableToOpen} $url';
  }
}

enum State { pending, retrieved, consumed }

enum PropagationMethod { bouture, graine }

State getStateByValue(String value) {
  switch (value) {
    case 'en attente':
      return State.pending;
    case 'récupérée':
      return State.retrieved;
    case 'consommée':
      return State.consumed;
    default:
      return State.pending;
  }
}

String getStateValue(State state) {
  switch (state) {
    case State.pending:
      return 'en attente';
    case State.retrieved:
      return 'récupérée';
    case State.consumed:
      return 'consommée';
  }
}

PropagationMethod getPropagationMethodByValue(String value) {
  switch (value) {
    case 'bouture':
      return PropagationMethod.bouture;
    case 'graine':
      return PropagationMethod.graine;
    default:
      return PropagationMethod.bouture;
  }
}

String getPropagationMethodValue(PropagationMethod propagationMethod) {
  switch (propagationMethod) {
    case PropagationMethod.bouture:
      return 'bouture';
    case PropagationMethod.graine:
      return 'graine';
  }
}

String monthToString(int month) {
  return SeedLibraryTextConstants.months[month - 1];
}

Color getColorFromDifficulty(int difficulty) {
  switch (difficulty) {
    case 1:
      return Colors.green;
    case 2:
      return Colors.yellow;
    case 3:
      return Colors.orange;
    case 4:
      return Colors.red;
    case 5:
      return Colors.black;
    default:
      return Colors.grey;
  }
}
