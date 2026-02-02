import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static Future<void> launchURLNewTab(String urlString) async {
    final uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        webOnlyWindowName: '_blank',
      );
    } else {
      throw Exception('Could not launch $urlString');
    }
  }
}
