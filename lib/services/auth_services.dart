import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final DatabaseService _dbService = DatabaseService();

  final Function(String) _showSnackBarCallback;

  AuthService(this._showSnackBarCallback);

  Future<User?> signUpWithEmailPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(displayName.trim());
        await user.reload();
        final User? updatedUser = _auth.currentUser;

        if (updatedUser != null) {
          await _dbService.createOrUpdateUser(updatedUser);

          print('Signed Up: ${updatedUser.displayName} (${updatedUser.email})');
          _showSnackBarCallback(
              'Registration successful! Welcome, ${updatedUser.displayName ?? ''}!');
          return updatedUser;
        }
      }
      return null;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'Password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Email is already registered.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Email is not valid.';
      } else {
        errorMessage = 'An error occurred during registration: ${e.message}';
      }
      _showSnackBarCallback(errorMessage);
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
        _showSnackBarCallback(
            'Successful login as ${user.displayName ?? user.email}!');
        return user;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'There are no users with that email address.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Password is incorrect.';
      } else {
        errorMessage = 'An error occurred during login: ${e.message}';
      }
      _showSnackBarCallback(errorMessage);
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _showSnackBarCallback('Login with Google was canceled.');
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        await _dbService.createOrUpdateUser(user);

        print('Signed in with Google: ${user.displayName}');
        _showSnackBarCallback(
            'Login with Google successful, ${user.displayName ?? ''}!');
        return user;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      _showSnackBarCallback('Failed to login with Google: ${e.message}');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      _showSnackBarCallback('Successfully signed out.');
    } catch (e) {
      _showSnackBarCallback('An unexpected error occurred when signing out.');
    }
  }

  Stream<User?> get user => _auth.authStateChanges();
}