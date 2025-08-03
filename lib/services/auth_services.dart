import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final Function(String) _showSnackBarCallback;

  AuthService(this._showSnackBarCallback);

  /// Handles user registration with email and password.
  /// Displays appropriate snackbar messages for success or failure.
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

      // Update display name for the newly created user
      await userCredential.user?.updateDisplayName(displayName.trim());
      // Reload user to get the updated display name
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
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Email tidak valid.';
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

  /// Handles user sign-in with email and password.
  /// Displays appropriate snackbar messages for success or failure.
  Future<User?> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final User? user = userCredential.user;

      if (user != null) {
        print('Signed In: ${user.displayName} (${user.email})');
        _showSnackBarCallback('Berhasil login sebagai ${user.displayName ?? user.email}!');
        return user;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'Tidak ada pengguna dengan email tersebut.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Password salah.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Email tidak valid.';
      } else if (e.code == 'user-disabled') {
        errorMessage = 'Akun pengguna ini telah dinonaktifkan.';
      }
      else {
        errorMessage = 'Terjadi kesalahan saat login: ${e.message}';
      }
      _showSnackBarCallback(errorMessage);
      return null;
    } catch (e) {
      print('Error signing in: $e');
      _showSnackBarCallback('Terjadi kesalahan tidak terduga.');
      return null;
    }
  }

  /// Handles user sign-in with Google.
  /// Displays appropriate snackbar messages for success or failure.
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

  /// Handles user sign-out.
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut(); // Also sign out from Google if signed in via Google
      _showSnackBarCallback('Berhasil keluar.');
    } catch (e) {
      print('Error signing out: $e');
      _showSnackBarCallback('Terjadi kesalahan saat keluar.');
    }
  }

  /// Provides a stream of the current user's authentication state.
  Stream<User?> get user => _auth.authStateChanges();
}
