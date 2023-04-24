import 'package:chatti_v2/features/firebase/firebase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuthService>((ref) => FirebaseAuthService());

final firestoreServiceProvider =
    Provider<FirestoreService>((ref) => FirestoreService());
