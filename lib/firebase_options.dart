// File: lib/firebase_options.dart
// Firebase project: katering-db
// Project Number:   1059796951441

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        return web;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBXKEh38QxXpqKek8WF03vYAOMnRPv3kew',
    appId: '1:1059796951441:web:a95319ea462b89034e7a30',
    messagingSenderId: '1059796951441',
    projectId: 'katering-db',
    authDomain: 'katering-db.firebaseapp.com',
    storageBucket: 'katering-db.firebasestorage.app',
    measurementId: 'G-VHFSRP5M24',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCrAOMZO_YuZz0CL2exkXZ79w-HAkUgK3c',
    appId: '1:1059796951441:android:026491d16e214bb94e7a30',
    messagingSenderId: '1059796951441',
    projectId: 'katering-db',
    storageBucket: 'katering-db.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCrAOMZO_YuZz0CL2exkXZ79w-HAkUgK3c',
    appId: '1:1059796951441:ios:000000000000000000000000',
    messagingSenderId: '1059796951441',
    projectId: 'katering-db',
    storageBucket: 'katering-db.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );
}
