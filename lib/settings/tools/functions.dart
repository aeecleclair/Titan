import 'package:titan/settings/tools/constants.dart';
import 'package:url_launcher/url_launcher.dart';

void openLink(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView);
  } else {
    throw '${SettingsTextConstants.unableToOpen} $url';
  }
}
