import 'package:url_launcher/url_launcher.dart';

final gpUrlLauncher = GPUrlLaucher();

class GPUrlLaucher {
  Future<bool> launch({
    required Uri uri,
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    if (await canLaunchUrl(uri)) {
      return launchUrl(
        uri,
        mode: mode,
      );
    }
    return false;
  }
}
