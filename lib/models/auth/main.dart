import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<Map<String, dynamic>> emailSignIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user != null
          ? {
              'user': result.user,
              'code': 'sign-in-success',
            }
          : {
              'code': 'sign-in-failed',
            };
    } on FirebaseAuthException catch (e) {
      return {
        'code': e.code,
      };
    }
  }

  Future<Map<String, dynamic>> emailSignUp({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user != null
          ? {'user': result.user, 'code': 'sign-up-success'}
          : {'code': 'sign-up-failed'};
    } on FirebaseAuthException catch (e) {
      return {'code': e.code};
    }
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential result = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      return {'user': result.user, 'code': 'sign-in-success'};
    } on FirebaseAuthException catch (e) {
      return {'code': e.code};
    }
  }
}
