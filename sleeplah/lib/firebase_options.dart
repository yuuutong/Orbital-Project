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
    apiKey: 'AIzaSyDIy7ZStrtoHwYiIKWlwY0Nq3jQ3oB6JcM',
    appId: '1:691967678435:web:00d048e361b6b7223732d6',
    messagingSenderId: '691967678435',
    projectId: 'orbital-8ba35',
    authDomain: 'orbital-8ba35.firebaseapp.com',
    storageBucket: 'orbital-8ba35.appspot.com',
    measurementId: 'G-8PTFLGE41R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDVWejWhB6zzCGpISXjqAlunZlA4FIqoBA',
    appId: '1:691967678435:android:5a15cf4269ac6b273732d6',
    messagingSenderId: '691967678435',
    projectId: 'orbital-8ba35',
    storageBucket: 'orbital-8ba35.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCTmBQmqSTOZJ9p2ljSaj7dwgeQ7N4Rlyg',
    appId: '1:691967678435:ios:c25f3fa52c9dbfc83732d6',
    messagingSenderId: '691967678435',
    projectId: 'orbital-8ba35',
    storageBucket: 'orbital-8ba35.appspot.com',
    iosClientId: '691967678435-ugeauenc2vu2or6j4c87grj2tr9qroh1.apps.googleusercontent.com',
    iosBundleId: 'com.example.sleeplah',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCTmBQmqSTOZJ9p2ljSaj7dwgeQ7N4Rlyg',
    appId: '1:691967678435:ios:c25f3fa52c9dbfc83732d6',
    messagingSenderId: '691967678435',
    projectId: 'orbital-8ba35',
    storageBucket: 'orbital-8ba35.appspot.com',
    iosClientId: '691967678435-ugeauenc2vu2or6j4c87grj2tr9qroh1.apps.googleusercontent.com',
    iosBundleId: 'com.example.sleeplah',
  );
}
