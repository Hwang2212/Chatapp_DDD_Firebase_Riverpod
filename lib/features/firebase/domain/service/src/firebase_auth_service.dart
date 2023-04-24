import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  int? _resendToken;
  int? get resendToken => _resendToken;

  FirebaseAuthService();

  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> emailLogIn(String email, String password) async {
    try {
      User? firebaseUser = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      // log(firebaseUser.toString());
      if (firebaseUser != null) {
        // locator<SharedPreferencesService>().setUserUid(firebaseUser.uid);
        // locator<SharedPreferencesService>()
        //     .setUserName(firebaseUser.displayName ?? "");
        // locator<SharedPreferencesService>().setHasLoggedIn();
        return firebaseUser;
      } else {
        throw Exception("Can't Log In with Email");
      }
    } catch (e) {
      throw Exception(e);
    }

    // notifyListeners();
  }

  Future<User?> signInWithCredential(AuthCredential credential) async {
    try {
      User? firebaseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;
      // log(firebaseUser.toString());
      if (firebaseUser != null) {
        // locator<SharedPreferencesService>().setUserUid(firebaseUser.uid);
        // locator<SharedPreferencesService>()
        //     .setUserName(firebaseUser.displayName ?? "");
        // locator<SharedPreferencesService>().setHasLoggedIn();
        return firebaseUser;
      } else {
        throw Exception("Can't Log In with Email");
      }
    } catch (e) {
      throw Exception(e);
    }

    // notifyListeners();
  }

  Future<User?> google() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication? googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        User? firebaseUser = (await signInWithCredential(credential));
        return firebaseUser;

        // log(firebaseUser.toString());
      } else {
        throw Exception("Can't Log In with Email");
      }
    } catch (e) {
      throw Exception(e);
    }

    // notifyListeners();
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    log("[Firebase Logout] ${firebaseAuth.currentUser}");
  }
}
