import 'dart:developer';

import 'package:chatti_v2/features/auth/application/auth_state.dart';
import 'package:chatti_v2/global_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_prefs/shared_prefs.dart';

import '../../firebase/firebase.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
      sharedPreferencesService: ref.watch(sharedPrefProvider),
      firebaseAuthService: ref.watch(firebaseAuthProvider),
      firestoreService: ref.watch(firestoreServiceProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final FirebaseAuthService firebaseAuthService;
  final FirestoreService firestoreService;
  final SharedPreferencesService sharedPreferencesService;
  AuthNotifier(
      {required this.firebaseAuthService,
      required this.firestoreService,
      required this.sharedPreferencesService})
      : super(const AuthState.initializing());

  Future<bool> googleLogIn() async {
    try {
      state = const AuthState.loading();
      User? firebaseUser = await firebaseAuthService.google();

      if (firebaseUser != null) {
        log(firebaseUser.toString());
        sharedPreferencesService.setUserUid(firebaseUser.uid);
        sharedPreferencesService.setUserName(firebaseUser.displayName ?? "");
        sharedPreferencesService.setHasLoggedIn();

        final QuerySnapshot result =
            await firestoreService.getUserDetails(firebaseUser.uid);
        final List<DocumentSnapshot> document = result.docs;
        if (document.isEmpty) {
          firestoreService.createUser(firebaseUser);
        }
        state = AuthState.authenticated(firebaseUser);
        return true;
      } else {
        state = AuthState.error("User failed", StackTrace.current);
        return false;
      }
    } catch (e, stackTrace) {
      state = AuthState.error(e.toString(), stackTrace);
      log(stackTrace.toString());
      log(e.toString());

      return false;
    }
  }

  Future<bool> emailSignIn(String email, String password) async {
    try {
      state = const AuthState.loading();
      User? firebaseUser =
          await firebaseAuthService.emailLogIn(email, password);

      if (firebaseUser != null) {
        log(firebaseUser.toString());
        sharedPreferencesService.setUserUid(firebaseUser.uid);
        sharedPreferencesService.setUserName(firebaseUser.displayName ?? "");
        sharedPreferencesService.setHasLoggedIn();

        final QuerySnapshot result =
            await firestoreService.getUserDetails(firebaseUser.uid);
        final List<DocumentSnapshot> document = result.docs;
        if (document.isEmpty) {
          firestoreService.createUser(firebaseUser);
        }
        state = AuthState.authenticated(firebaseUser);
        return true;
      } else {
        state = AuthState.error("User failed", StackTrace.current);
        return false;
      }
    } catch (e, stackTrace) {
      state = AuthState.error(e.toString(), stackTrace);
      return false;
    }
  }
}
