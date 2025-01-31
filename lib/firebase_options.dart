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
    apiKey: 'AIzaSyAEA7KJS1aUawJeqhtUJlralVaSqRP8og0',
    appId: '1:128738328947:web:9f8dd2f71b34d959c68506',
    messagingSenderId: '128738328947',
    projectId: 'd-scan-1057d',
    authDomain: 'd-scan-1057d.firebaseapp.com',
    storageBucket: 'd-scan-1057d.appspot.com',
    measurementId: 'G-VGTSGXMSZ7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCQfGP3k4B-eIkm-S1T9OIddZdAF6mg7SI',
    appId: '1:128738328947:android:2bce4db4d2a4dbaec68506',
    messagingSenderId: '128738328947',
    projectId: 'd-scan-1057d',
    storageBucket: 'd-scan-1057d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnCTydRwr0N7CXDYu4fIqD-oDl980ia-s',
    appId: '1:128738328947:ios:df03998fef5f8d50c68506',
    messagingSenderId: '128738328947',
    projectId: 'd-scan-1057d',
    storageBucket: 'd-scan-1057d.appspot.com',
    iosBundleId: 'com.example.dScanAdmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCnCTydRwr0N7CXDYu4fIqD-oDl980ia-s',
    appId: '1:128738328947:ios:975c8ce268bb9848c68506',
    messagingSenderId: '128738328947',
    projectId: 'd-scan-1057d',
    storageBucket: 'd-scan-1057d.appspot.com',
    iosBundleId: 'com.example.dScanAdmin.RunnerTests',
  );
}
