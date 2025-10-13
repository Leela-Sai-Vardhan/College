import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String? _currentUserRole; // Variable to store the current user role

  // Sign in as Faculty
  Future<User?> signInAsFaculty() async {
    if (_currentUserRole == 'student') {
      await _signOutGoogle(); // Sign out if currently signed in as student
    }
    _currentUserRole = 'faculty'; // Set the role to faculty
    return await _signInWithGoogle();
  }

  // Sign in as Student
  Future<User?> signInAsStudent() async {
    if (_currentUserRole == 'faculty') {
      await _signOutGoogle(); // Sign out if currently signed in as faculty
    }
    _currentUserRole = 'student'; // Set the role to student
    return await _signInWithGoogle();
  }

  // Common Google Sign-In Method
  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser  = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // If the user cancels the sign-in
      }
      final GoogleSignInAuthentication googleAuth = await googleUser !.authentication;

      final UserCredential userCredential = await _auth.signInWithCredential(
        GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        ),
      );

      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Sign Out Method
  Future<void> _signOutGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    _currentUserRole = null; // Reset the role
  }
}