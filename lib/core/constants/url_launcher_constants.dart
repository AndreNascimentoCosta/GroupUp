import 'package:flutter/foundation.dart';

class UrlLauncherConstants {
  const UrlLauncherConstants._();

  factory UrlLauncherConstants() => const UrlLauncherConstants._();

  static Uri emailAddress({required String subject, String body = ''}) {
    return Uri(
      scheme: 'mailto',
      path: 'groupupapp@outlook.com',
      query: 'subject=$subject&body=$body',
    );
  }

  static Uri store() {
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return Uri(
        scheme: 'https',
        host: 'play.google.com',
        path: 'store/apps/details',
        queryParameters: {
          'id': 'com.andrecosta.groupup',
        },
      );
    case TargetPlatform.iOS:
      return Uri(
        scheme: 'https',
        host: 'apps.apple.com',
        path: 'app/groupup-get-it-now/id1667979922',
      );
    default:
      throw UnsupportedError('Platform not supported');
  }
}

  static final termsOfUse = Uri(
    scheme: 'https',
    host: 'limboo.co',
    path: '/apps/cheerz/terms-of-use',
  );

  static final privacyPolicy = Uri(
    scheme: 'https',
    host: 'groupup.rf.gd',
    path: '/privacy-policy.html',
  );

  static final limbooStoreUrl = Uri(
    scheme: 'https',
    host: 'limboo.co',
    path: '/apps/cheerz/app',
  );

  static const limbooStoreUrlText = 'https://limboo.co/apps/cheerz/app';
}
