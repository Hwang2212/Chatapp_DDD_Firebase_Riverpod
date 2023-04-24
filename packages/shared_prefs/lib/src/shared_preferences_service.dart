import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_prefs/src/shared_preferences_constants.dart';

class SharedPreferencesService {
  static SharedPreferences? _sharedPreferences;
  static SharedPreferencesService? _instance;

  // Initialize Shared Preferences
  static Future<SharedPreferencesService> getInstance() async {
    if (_instance != null) return _instance!;
    _sharedPreferences =
        _sharedPreferences ?? await SharedPreferences.getInstance();
    _instance = SharedPreferencesService();
    return _instance!;
  }

  Future<bool> setUserUid(String userUid) {
    return _sharedPreferences!.setString(SharedPrefConstants.userUid, userUid);
  }

  Future<bool> setUserName(String username) {
    return _sharedPreferences!
        .setString(SharedPrefConstants.username, username);
  }

  String? getUsername() {
    return _sharedPreferences!.getString(SharedPrefConstants.username);
  }

  String? getUserUid() {
    return _sharedPreferences!.getString(SharedPrefConstants.userUid);
  }

  // // Key-pair Values Getter and Setter
  bool getHasLoggedIn() {
    return _sharedPreferences!.getBool(SharedPrefConstants.hasLoggedIn) ??
        false;
  }

  Future<bool> setHasLoggedIn() async {
    return _sharedPreferences!.setBool(SharedPrefConstants.hasLoggedIn, true);
  }

  // String getAccessToken() {
  //   return _sharedPreferences!.getString(Constants.accessToken) ?? "";
  // }

  // Future<bool> gsetAccessToken(String value) async {
  //   return _sharedPreferences!.setString(Constants.accessToken, value);
  // }

  // Future<bool> saveFcmToken(String value) async {
  //   return _sharedPreferences!.setString(Constants.fcmToken, value);
  // }

  Future<bool> clear() async {
    return _sharedPreferences!.clear();
  }

  // Future<void> saveAuthModel(AuthModel authModel) async {
  //   await _sharedPreferences?.setString(
  //       Constants.accessToken, authModel.accessToken);
  // }

  // void refreshToken(String accessToken, String refreshToken) {
  //   _sharedPreferences?.setString(Constants.accessToken, accessToken);
  //   _sharedPreferences?.setString(Constants.refreshToken, refreshToken);
  //   return;
  // }
}
