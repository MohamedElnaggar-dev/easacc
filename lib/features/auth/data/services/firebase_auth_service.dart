import 'dart:developer';

import 'package:easacc_app/core/utils/error_handler/custom_excption.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
      final LoginResult result = await FacebookAuth.instance.login();
      log("Facebook login status: ${result.status}");
      log("Facebook login message: ${result.message}");
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;

        final OAuthCredential credential = FacebookAuthProvider.credential(
          accessToken.tokenString,
        );

        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(credential);

        final user = userCredential.user!;

        return user;
      } else if (result.status == LoginStatus.cancelled) {
        throw CustomException(errMessage: 'Facebook sign-in was cancelled.');
      } else {
        throw CustomException(
          errMessage: result.message ?? 'Unknown Facebook login error.',
        );
      }
    } catch (e) {
      throw CustomException(errMessage: e.toString());
    }
  }
}
