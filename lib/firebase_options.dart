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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyA6B9tiPygLyIXdL6A8ASKqPr2Pph85Kdw',
    appId: '1:228858929431:web:19177eae370b61f6fad752',
    messagingSenderId: '228858929431',
    projectId: 'centsei-14a6d',
    authDomain: 'centsei-14a6d.firebaseapp.com',
    storageBucket: 'centsei-14a6d.appspot.com',
    measurementId: 'G-D1WJ86F0XD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAp8KgXVMz0sfLsi4PPEKNTC_a2Oc594c4',
    appId: '1:228858929431:android:12facdb4f5107b5afad752',
    messagingSenderId: '228858929431',
    projectId: 'centsei-14a6d',
    storageBucket: 'centsei-14a6d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBNtBSXeC5r4ghy6cOfcyZVj8K7EZDjtlo',
    appId: '1:228858929431:ios:59260b6ead9d978ffad752',
    messagingSenderId: '228858929431',
    projectId: 'centsei-14a6d',
    storageBucket: 'centsei-14a6d.appspot.com',
    iosBundleId: 'dev.treknuts.centsei',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBNtBSXeC5r4ghy6cOfcyZVj8K7EZDjtlo',
    appId: '1:228858929431:ios:59260b6ead9d978ffad752',
    messagingSenderId: '228858929431',
    projectId: 'centsei-14a6d',
    storageBucket: 'centsei-14a6d.appspot.com',
    iosBundleId: 'dev.treknuts.centsei',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA6B9tiPygLyIXdL6A8ASKqPr2Pph85Kdw',
    appId: '1:228858929431:web:299fb06a1ee49e58fad752',
    messagingSenderId: '228858929431',
    projectId: 'centsei-14a6d',
    authDomain: 'centsei-14a6d.firebaseapp.com',
    storageBucket: 'centsei-14a6d.appspot.com',
    measurementId: 'G-1W4EYJ99T2',
  );
}
