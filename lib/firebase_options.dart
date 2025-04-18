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
    apiKey: 'AIzaSyDvcjgJT8LZ3APpJyU3y9qnA1-hHuH2q2c',
    appId: '1:482521837491:web:6d5293bb2a859d6e7c65c6',
    messagingSenderId: '482521837491',
    projectId: 'sentinova-hackfest-25',
    authDomain: 'sentinova-hackfest-25.firebaseapp.com',
    storageBucket: 'sentinova-hackfest-25.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDIntDR0nQJjCn9jvmySd92wG-CSY_mRFg',
    appId: '1:482521837491:android:736ef129a1318c017c65c6',
    messagingSenderId: '482521837491',
    projectId: 'sentinova-hackfest-25',
    storageBucket: 'sentinova-hackfest-25.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyArofrIS_93IEATjsZLPsbmvDht16AyJa4',
    appId: '1:482521837491:ios:07da6978c9e5bb397c65c6',
    messagingSenderId: '482521837491',
    projectId: 'sentinova-hackfest-25',
    storageBucket: 'sentinova-hackfest-25.firebasestorage.app',
    iosBundleId: 'com.example.sentinova',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyArofrIS_93IEATjsZLPsbmvDht16AyJa4',
    appId: '1:482521837491:ios:07da6978c9e5bb397c65c6',
    messagingSenderId: '482521837491',
    projectId: 'sentinova-hackfest-25',
    storageBucket: 'sentinova-hackfest-25.firebasestorage.app',
    iosBundleId: 'com.example.sentinova',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDvcjgJT8LZ3APpJyU3y9qnA1-hHuH2q2c',
    appId: '1:482521837491:web:946b829f4851bae97c65c6',
    messagingSenderId: '482521837491',
    projectId: 'sentinova-hackfest-25',
    authDomain: 'sentinova-hackfest-25.firebaseapp.com',
    storageBucket: 'sentinova-hackfest-25.firebasestorage.app',
  );
}
