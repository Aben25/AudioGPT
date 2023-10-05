import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDT_mxZCnFdTjY3NRi_qTB7WHXiYDP_1AA",
            authDomain: "testing-8b1e4.firebaseapp.com",
            projectId: "testing-8b1e4",
            storageBucket: "testing-8b1e4.appspot.com",
            messagingSenderId: "655978775077",
            appId: "1:655978775077:web:a36f1e000c6cfc9ae4f5cc",
            measurementId: "G-5SHTW6B1TL"));
  } else {
    await Firebase.initializeApp();
  }
}
