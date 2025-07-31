import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import '../firebase_options.dart'; // Pastikan jalur ini benar ke file firebase_options.dart Anda

class FirebaseService {
  // Metode statis untuk menginisialisasi Firebase
  static Future<void> initializeFirebase() async {
    // Pastikan binding widget Flutter diinisialisasi.
    // Ini penting sebelum memanggil plugin spesifik platform seperti Firebase.
    WidgetsFlutterBinding.ensureInitialized();

    // Periksa apakah Firebase sudah diinisialisasi untuk mencegah kesalahan pada hot reload atau masuk kembali
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print('Firebase berhasil diinisialisasi.');
    } else {
      print('Firebase sudah diinisialisasi.');
    }
  }
}
