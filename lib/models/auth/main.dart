import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skip_q_lah/models/constants.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<JsonResponse> anonSignIn() async {
    try {
      UserCredential result = await _firebaseAuth.signInAnonymously();

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

  Future<JsonResponse> emailSignIn({
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

  Future<JsonResponse> emailSignUp({
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

  Future<JsonResponse> signInWithGoogle() async {
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

      if (result.user != null) {
        DocumentSnapshot<JsonResponse> userDocs = await FirebaseFirestore
            .instance
            .collection('users')
            .doc(result.user!.uid)
            .get();
        return {
          'user': result.user,
          'code': 'sign-in-success',
          'exists': userDocs.exists,
        };
      } else {
        return {'code': 'sign-in-failed'};
      }
    } on FirebaseAuthException catch (e) {
      return {'code': e.code};
    }
  }
}
