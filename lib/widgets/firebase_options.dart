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
    apiKey: 'AIzaSyCSlGJOX7jCWsNFtjbC8I96UB1Kfcgkt1I',
    appId: '1:628854870739:web:d4675dff295851629e3a26',
    messagingSenderId: '628854870739',
    projectId: 'reserviopfe',
    authDomain: 'reserviopfe.firebaseapp.com',
    storageBucket: 'reserviopfe.appspot.com',
    measurementId: 'G-224065NJZC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAcvM9W2zicZB_wmV0j7bajVF59JaucYHA',
    appId: '1:628854870739:android:8ca8679d064902409e3a26',
    messagingSenderId: '628854870739',
    projectId: 'reserviopfe',
    storageBucket: 'reserviopfe.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBGsfeRcR5nTDwMyQ1mldSCBw0t35j94XE',
    appId: '1:628854870739:ios:d76f05dbc42cf62d9e3a26',
    messagingSenderId: '628854870739',
    projectId: 'reserviopfe',
    storageBucket: 'reserviopfe.appspot.com',
    iosBundleId: 'com.example.reserviov1',
  );
}
