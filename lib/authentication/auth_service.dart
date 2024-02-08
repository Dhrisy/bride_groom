import 'package:firebase_auth/firebase_auth.dart';

class AuthSignUpService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signUpWithEmailPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Sign-up successful, return null for no error
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message if sign-up fails
    }
  }
  Future<String?> getCurrentUserId() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return user.uid;
      }
      return null; // User is not logged in
    } catch (e) {
      print('Error getting current user ID: $e');
      return null;
    }
  }
}

class AuthSignInService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signInWithEmailPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null; // Sign-in successful, return null for no error
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message if sign-in fails
    }
  }
}
