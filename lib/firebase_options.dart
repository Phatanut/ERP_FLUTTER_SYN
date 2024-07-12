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
    apiKey: 'AIzaSyCIPqoO8ltPZRsnUZlB_Wd6JPlmZnoF9W4',
    appId: '1:831160044147:web:fa78b497bf25e9b382b806',
    messagingSenderId: '831160044147',
    projectId: 'inventoryapps-632b3',
    authDomain: 'inventoryapps-632b3.firebaseapp.com',
    storageBucket: 'inventoryapps-632b3.appspot.com',
    measurementId: 'G-DXEEJ35465',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADX9_XzWRx9UMw6jLvv35sKursMcg_ZqE',
    appId: '1:831160044147:android:bfcf2e4e56c2445d82b806',
    messagingSenderId: '831160044147',
    projectId: 'inventoryapps-632b3',
    storageBucket: 'inventoryapps-632b3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAzK8VSX-xRN-A1vlrkMj6DxOcwQSiuJZA',
    appId: '1:831160044147:ios:8cd1df6f4067d35582b806',
    messagingSenderId: '831160044147',
    projectId: 'inventoryapps-632b3',
    storageBucket: 'inventoryapps-632b3.appspot.com',
    iosBundleId: 'com.example.inventoryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAzK8VSX-xRN-A1vlrkMj6DxOcwQSiuJZA',
    appId: '1:831160044147:ios:efff7fa8029615fd82b806',
    messagingSenderId: '831160044147',
    projectId: 'inventoryapps-632b3',
    storageBucket: 'inventoryapps-632b3.appspot.com',
    iosBundleId: 'com.example.inventoryApp.RunnerTests',
  );
}
