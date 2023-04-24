import 'package:chatti_v2/services/service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_prefs/shared_prefs.dart';

final sharedPrefProvider = Provider<SharedPreferencesService>((ref) {
  return SharedPreferencesService();
});

final firebaseinitializerProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp();
});
// final sharedPrefsServe = FutureProvider<SharedPreferencesService>((ref) async {
//   return await SharedPreferencesService.getInstance();
// });

final snackBarProvider = Provider((ref) => SnackBarService());
