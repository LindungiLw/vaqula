import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
        _showSnackBarCallback('Registration successful! Welcome!, ${updatedUser.displayName ?? updatedUser.email}!');
        return updatedUser;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'Password is too weak.';
      } else if (e.code == 'email is already in use!') {
        errorMessage = 'Email is already registered.';
      } else if (e.code == 'invalid email') {
        errorMessage = 'Email is not valid.';
      } else {
        errorMessage = 'An error occurred during registration.: ${e.message}';
      }
      _showSnackBarCallback(errorMessage);
      return null;
    } catch (e) {
      print('Error signing up: $e');
      _showSnackBarCallback('An unexpected error occurred.');
      return null;
    }
  }

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
        _showSnackBarCallback('Successful login as ${user.displayName ?? user.email}!');
        return user;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'There are no users with that email address..';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Password is incorrect.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Email is not valid.';
      } else if (e.code == 'user-disabled') {
        errorMessage = 'The user account has been disabled.';
      }
      else {
        errorMessage = 'An error occurred during login: ${e.message}';
      }
      _showSnackBarCallback(errorMessage);
      return null;
    } catch (e) {
      print('Error signing in: $e');
      _showSnackBarCallback('An unexpected error occurred.');
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _showSnackBarCallback('login with Google failed.');
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
        _showSnackBarCallback('Login with Google successful!, ${user.displayName ?? user.email}!');
        return user;
      } else {
        _showSnackBarCallback('fail to get information with Google.');
        return null;
      }
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error Google: ${e.code} - ${e.message}');
      _showSnackBarCallback('fail to login with Google: ${e.message}');
      return null;
    } catch (e) {
      print('Error sign in with Google: $e');

      print('Error sign in with Google: $e');
      _showSnackBarCallback('An occurred error.');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      _showSnackBarCallback('Successfully signed out.');
    } catch (e) {
      print('Error signing out: $e');
      _showSnackBarCallback('An unexpected error occurred when signing out.');
    }
  }

  Stream<User?> get user => _auth.authStateChanges();
}
