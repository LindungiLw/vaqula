import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart'; // Diperlukan untuk SnackBar dan context

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Callback untuk menampilkan SnackBar
  final Function(String) _showSnackBarCallback;

  AuthService(this._showSnackBarCallback);

  Future<User?> signUpWithEmailPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await userCredential.user?.updateDisplayName(displayName.trim());
      await userCredential.user?.reload();
      final User? updatedUser = _auth.currentUser;

      if (updatedUser != null) {
        print('Signed Up: ${updatedUser.displayName} (${updatedUser.email})');
        _showSnackBarCallback('Pendaftaran berhasil! Selamat datang, ${updatedUser.displayName ?? updatedUser.email}!');
        return updatedUser;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'Password terlalu lemah.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Email sudah terdaftar.';
      } else {
        errorMessage = 'Terjadi kesalahan saat pendaftaran: ${e.message}';
      }
      _showSnackBarCallback(errorMessage);
      return null;
    } catch (e) {
      print('Error signing up: $e');
      _showSnackBarCallback('Terjadi kesalahan tidak terduga.');
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _showSnackBarCallback('Login Google dibatalkan.');
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        print('Signed in with Google: ${user.displayName}');
        _showSnackBarCallback('Berhasil login dengan Google sebagai ${user.displayName ?? user.email}!');
        return user;
      } else {
        _showSnackBarCallback('Gagal mendapatkan informasi pengguna dari Google.');
        return null;
      }
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error Google: ${e.code} - ${e.message}');
      _showSnackBarCallback('Gagal login dengan Google: ${e.message}');
      return null;
    } catch (e) {
      print('Error signing in with Google: $e');
      _showSnackBarCallback('Terjadi kesalahan tidak terduga saat login Google.');
      return null;
    }
  }
}
