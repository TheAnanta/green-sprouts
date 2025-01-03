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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDTxHTX0uFaQT5rFAsZRaJCstEKyYu5F74',
    appId: '1:733302982386:web:c2fe3bc78310a618c2726b',
    messagingSenderId: '733302982386',
    projectId: 'stemquest-ai-genkit-ananta',
    authDomain: 'stemquest-ai-genkit-ananta.firebaseapp.com',
    storageBucket: 'stemquest-ai-genkit-ananta.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAuNjfxtAlsoUM5WLTKGXisT8qjI_Tz9dQ',
    appId: '1:733302982386:ios:3825a2422d9ac1abc2726b',
    messagingSenderId: '733302982386',
    projectId: 'stemquest-ai-genkit-ananta',
    storageBucket: 'stemquest-ai-genkit-ananta.firebasestorage.app',
    iosBundleId: 'in.theananta.stemquest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAuNjfxtAlsoUM5WLTKGXisT8qjI_Tz9dQ',
    appId: '1:733302982386:ios:3825a2422d9ac1abc2726b',
    messagingSenderId: '733302982386',
    projectId: 'stemquest-ai-genkit-ananta',
    storageBucket: 'stemquest-ai-genkit-ananta.firebasestorage.app',
    iosBundleId: 'in.theananta.stemquest',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDTxHTX0uFaQT5rFAsZRaJCstEKyYu5F74',
    appId: '1:733302982386:web:fa9855a547ff42a7c2726b',
    messagingSenderId: '733302982386',
    projectId: 'stemquest-ai-genkit-ananta',
    authDomain: 'stemquest-ai-genkit-ananta.firebaseapp.com',
    storageBucket: 'stemquest-ai-genkit-ananta.firebasestorage.app',
  );
}
