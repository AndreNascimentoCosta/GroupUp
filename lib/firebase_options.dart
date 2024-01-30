// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAQLbAOdOAjraacbt408kyMHI3ZIV_-l28',
    appId: '1:703700374903:android:fc348b09e55c72414cbd72',
    messagingSenderId: '703700374903',
    projectId: 'groupup-432b8',
    storageBucket: 'groupup-432b8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADo9j5EPWduzbYkvfm46vV-exCrwNi_e4',
    appId: '1:703700374903:ios:26f9849b59358b154cbd72',
    messagingSenderId: '703700374903',
    projectId: 'groupup-432b8',
    storageBucket: 'groupup-432b8.appspot.com',
    iosClientId: '703700374903-phon209a2g1su55bi32gqt126b2vg94n.apps.googleusercontent.com',
    iosBundleId: 'com.andrecosta.groupup',
  );
}
