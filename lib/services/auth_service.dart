import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> signUp(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          throw Exception("This email is already registered.");
        case "invalid-email":
          throw Exception("The email address is not valid.");
        case "weak-password":
          throw Exception(
            "The password is too weak. Please use a stronger password.",
          );
        default:
          throw Exception("Signup failed. ${e.message}");
      }
    } catch (_) {
      throw Exception("An unknown error occurred during signup.");
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          throw Exception("No user found for this email.");
        case "wrong-password":
          throw Exception("Wrong password. Please try again.");
        case "invalid-credential":
          throw Exception(
            "Invalid credentials. Please check your email and password.",
          );
        default:
          throw Exception("Login failed. ${e.message}");
      }
    } catch (_) {
      throw Exception("An unknown error occurred during login.");
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (_) {
      throw Exception("Logout failed. Please try again.");
    }
  }
}
