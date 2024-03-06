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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyA62ZaZ34uteQJie7f_qVGpokd7dMPbvdY',
    appId: '1:562708057692:web:c86dfa3b097e8c81f16099',
    messagingSenderId: '562708057692',
    projectId: 'dboy-2d0d7',
    authDomain: 'dboy-2d0d7.firebaseapp.com',
    storageBucket: 'dboy-2d0d7.appspot.com',
    measurementId: 'G-238R3P3M5J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADLhUnOBv80Nd2RyMNgVtu2okB2kU07nI',
    appId: '1:562708057692:android:c7520ad0c0a6cd02f16099',
    messagingSenderId: '562708057692',
    projectId: 'dboy-2d0d7',
    storageBucket: 'dboy-2d0d7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYMj9yxhswQltdB2DBUzGa4W-2DKnKigc',
    appId: '1:562708057692:ios:f28daa237cf4f059f16099',
    messagingSenderId: '562708057692',
    projectId: 'dboy-2d0d7',
    storageBucket: 'dboy-2d0d7.appspot.com',
    iosBundleId: 'com.example.boy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCYMj9yxhswQltdB2DBUzGa4W-2DKnKigc',
    appId: '1:562708057692:ios:6033ff567b3b53c8f16099',
    messagingSenderId: '562708057692',
    projectId: 'dboy-2d0d7',
    storageBucket: 'dboy-2d0d7.appspot.com',
    iosBundleId: 'com.example.boy.RunnerTests',
  );
}
