import 'package:easacc_app/core/utils/error_handeling/custom_excption.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService(this._firebaseAuth);

  Future<User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw CustomException(errMessage: "Google sign-in was cancelled.");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);

      final user = userCredential.user;

      if (user == null) {
        throw CustomException(
          errMessage: "Google sign-in failed. No user returned.",
        );
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw CustomException(
        errMessage: e.message ?? "FirebaseAuth Google error.",
      );
    } catch (e) {
      throw CustomException(errMessage: "Google sign-in failed: $e");
    }
  }

  Future<User> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(facebookAuthCredential);

      final user = userCredential.user;

      if (user == null) {
        throw CustomException(
          errMessage: "Google sign-in failed. No user returned.",
        );
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw CustomException(
        errMessage: e.message ?? "FirebaseAuth Google error.",
      );
    } catch (e) {
      throw CustomException(errMessage: "Google sign-in failed: $e");
    }
  }
}
