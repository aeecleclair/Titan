import 'package:myecl/seed-library/tools/constants.dart';
import 'package:url_launcher/url_launcher.dart';

void openLink(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    throw '${SeedLibraryTextConstants.unableToOpen} $url';
  }
}
