import 'package:myecl/seed-library/tools/constants.dart';
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
    case 'récupéré':
      return State.retrieved;
    case 'consommé':
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
      return 'récupéré';
    case State.consumed:
      return 'consommé';
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
