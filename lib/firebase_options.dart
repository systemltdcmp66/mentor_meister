// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyASBmQbSGZFtbEG5F6Yxuv6qPPCCUGhw_0',
    appId: '1:703211532789:web:a571bc01bdfef36eb630bc',
    messagingSenderId: '703211532789',
    projectId: 'mentormeister-6021a',
    authDomain: 'mentormeister-6021a.firebaseapp.com',
    storageBucket: 'mentormeister-6021a.appspot.com',
    measurementId: 'G-9R9F37R332',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB4rpo9HkanvfyMg_eQMQevbA793cvmwkM',
    appId: '1:703211532789:android:e3480a141f7ead46b630bc',
    messagingSenderId: '703211532789',
    projectId: 'mentormeister-6021a',
    storageBucket: 'mentormeister-6021a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHyb0uhDzQvBa63Tv4wm9wKXv_EEZTB6E',
    appId: '1:703211532789:ios:57a1f89764f23386b630bc',
    messagingSenderId: '703211532789',
    projectId: 'mentormeister-6021a',
    storageBucket: 'mentormeister-6021a.appspot.com',
    androidClientId: '703211532789-9r6a39g3ihkm775075m57u092rca4rcu.apps.googleusercontent.com',
    iosClientId: '703211532789-sle38aanochc5mplrafhg1h8mhaf4rc5.apps.googleusercontent.com',
    iosBundleId: 'com.example.mentormeister',
  );

}