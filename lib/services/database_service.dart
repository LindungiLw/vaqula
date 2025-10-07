import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Menyimpan data pengguna baru ke koleksi 'users'
  Future<void> saveUserData({
    required String uid,
    required String displayName,
    required String email,
  }) async {
    try {
      await _db.collection('users').doc(uid).set({
        'displayName': displayName,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(), // Simpan waktu pembuatan
      });
    } catch (e) {
      print('Error saving user data: $e');
      // Anda bisa melempar error kembali atau menanganinya di sini
      rethrow;
    }
  }

  /// Mengambil data pengguna dari Firestore berdasarkan UID
  Future<DocumentSnapshot> getUserData(String uid) async {
    try {
      return await _db.collection('users').doc(uid).get();
    } catch (e) {
      print('Error getting user data: $e');
      rethrow;
    }
  }
}