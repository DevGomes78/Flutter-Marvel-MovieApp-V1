
import 'package:url_launcher/url_launcher.dart';

void callVideoPlayer() async {
  const url = 'https://github.com/DevGomes78';
  if (await launch(url)) {
    await launch(
      url,
      enableJavaScript: true,
      forceWebView: true,
    );
  } else {
    throw 'Could not launch $url';
  }
}