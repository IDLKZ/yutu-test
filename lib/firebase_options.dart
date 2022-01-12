// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRu8sX6TL0mpZLz_Mwb_I9UGuFvQc3VO8',
    appId: '1:537505589758:android:12dc35c4e3060d27f738af',
    messagingSenderId: '537505589758',
    projectId: 'findout-bde97',
    storageBucket: 'findout-bde97.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBERxB_vy2eQeuYocYP5CseDPCXwn6fYmo',
    appId: '1:537505589758:ios:4bc2115f51e242b0f738af',
    messagingSenderId: '537505589758',
    projectId: 'findout-bde97',
    storageBucket: 'findout-bde97.appspot.com',
    iosClientId: '537505589758-0qa15l1fi58k8jcfp7jm3tqu644argm4.apps.googleusercontent.com',
    iosBundleId: 'com.findout.app',
  );
}
