// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCN7YDAVWVyV2KvYz8qEDBbR_JrB6zEkAU',
    appId: '1:530581983851:web:ed9749d383796708ac972e',
    messagingSenderId: '530581983851',
    projectId: 'tas-project-26686',
    authDomain: 'tas-project-26686.firebaseapp.com',
    storageBucket: 'tas-project-26686.appspot.com',
    measurementId: 'G-KHQ2HJNS77',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB31oLTIfzzWUkPKfTbP2Hy88Fp9C21FWQ',
    appId: '1:530581983851:android:8b59d0a15e5c07bbac972e',
    messagingSenderId: '530581983851',
    projectId: 'tas-project-26686',
    storageBucket: 'tas-project-26686.appspot.com',
  );
}