import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrlStart({required String url}) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication);
  } else {
    throw 'Could not launch $url';
  }
}
