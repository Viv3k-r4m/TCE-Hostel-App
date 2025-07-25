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
    apiKey: 'AIzaSyC02ovdsfs7z_lJt7lND7XVy99lUmuzcnA',
    appId: '1:20795739195:web:5347e3c34c69f707ae601e',
    messagingSenderId: '20795739195',
    projectId: 'hostel-app-238b0',
    authDomain: 'hostel-app-238b0.firebaseapp.com',
    storageBucket: 'hostel-app-238b0.firebasestorage.app',
    measurementId: 'G-53290V8GGH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDE2Sn0Hms3C05lts24EDeSfV56prXgcSA',
    appId: '1:20795739195:android:b596f292ac8ea3ebae601e',
    messagingSenderId: '20795739195',
    projectId: 'hostel-app-238b0',
    storageBucket: 'hostel-app-238b0.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD61DVSQCMNcF0NItwxg39IYAU0YTV-kZs',
    appId: '1:20795739195:ios:c266611e75358f58ae601e',
    messagingSenderId: '20795739195',
    projectId: 'hostel-app-238b0',
    storageBucket: 'hostel-app-238b0.firebasestorage.app',
    iosBundleId: 'com.example.hostel',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD61DVSQCMNcF0NItwxg39IYAU0YTV-kZs',
    appId: '1:20795739195:ios:c266611e75358f58ae601e',
    messagingSenderId: '20795739195',
    projectId: 'hostel-app-238b0',
    storageBucket: 'hostel-app-238b0.firebasestorage.app',
    iosBundleId: 'com.example.hostel',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC02ovdsfs7z_lJt7lND7XVy99lUmuzcnA',
    appId: '1:20795739195:web:2955093c5a8bd927ae601e',
    messagingSenderId: '20795739195',
    projectId: 'hostel-app-238b0',
    authDomain: 'hostel-app-238b0.firebaseapp.com',
    storageBucket: 'hostel-app-238b0.firebasestorage.app',
    measurementId: 'G-9J33YGVZKF',
  );
}
