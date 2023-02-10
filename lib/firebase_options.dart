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
    apiKey: 'AIzaSyCbvjpkf5LvzNJNiCerekP3OORhjfs1DHo',
    appId: '1:345065878278:web:f2a0d1455436e99d9d6487',
    messagingSenderId: '345065878278',
    projectId: 'simple-notes-blueprint',
    authDomain: 'simple-notes-blueprint.firebaseapp.com',
    storageBucket: 'simple-notes-blueprint.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdSNkCjtAPO4NSUeSkWYyP_iaUBZEERtM',
    appId: '1:345065878278:android:e12034bd03b3a8779d6487',
    messagingSenderId: '345065878278',
    projectId: 'simple-notes-blueprint',
    storageBucket: 'simple-notes-blueprint.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBFVrg4iLpL5R4Xr-Vcrp3xLGT4sGyTu5s',
    appId: '1:345065878278:ios:dbd940bc110079c99d6487',
    messagingSenderId: '345065878278',
    projectId: 'simple-notes-blueprint',
    storageBucket: 'simple-notes-blueprint.appspot.com',
    iosClientId: '345065878278-968gk6eqc8n7ejuh2ibaq0as496fkrcp.apps.googleusercontent.com',
    iosBundleId: 'com.example.simpleNotesBlueprint',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBFVrg4iLpL5R4Xr-Vcrp3xLGT4sGyTu5s',
    appId: '1:345065878278:ios:dbd940bc110079c99d6487',
    messagingSenderId: '345065878278',
    projectId: 'simple-notes-blueprint',
    storageBucket: 'simple-notes-blueprint.appspot.com',
    iosClientId: '345065878278-968gk6eqc8n7ejuh2ibaq0as496fkrcp.apps.googleusercontent.com',
    iosBundleId: 'com.example.simpleNotesBlueprint',
  );
}
