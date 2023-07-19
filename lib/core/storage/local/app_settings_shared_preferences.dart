import 'package:act_hub_app/config/constants.dart';
import 'package:act_hub_app/core/extensions/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsSharedPreferences {
  final SharedPreferences _sharedPreferences;

  AppSettingsSharedPreferences(this._sharedPreferences);

  Future<void> setOutBoardingViewed() async {
    await _sharedPreferences.setBool(
      ConstantsPrefsKeys.outBoardingViewedKey,
      true,
    );
  }

  bool getOutBoardingViewed() {
    return _sharedPreferences
        .getBool(
          ConstantsPrefsKeys.outBoardingViewedKey,
        )
        .onNull();
  }

  Future<void> setToken(String token) async {
    await _sharedPreferences.setString(ConstantsPrefsKeys.token, token);
  }

  String getToken() {
    return _sharedPreferences.getString(ConstantsPrefsKeys.token).onNull();
  }

  Future<void> setEmail(String email) async {
    await _sharedPreferences.setString(ConstantsPrefsKeys.email, email);
  }

  String getEmail() {
    return _sharedPreferences.getString(ConstantsPrefsKeys.email).onNull();
  }

  Future<void> setPassword(String password) async {
    await _sharedPreferences.setString(ConstantsPrefsKeys.password, password);
  }

  String getPassword() {
    return _sharedPreferences.getString(ConstantsPrefsKeys.password).onNull();
  }

  Future<void> setLoggedIn() async {
    await _sharedPreferences.setBool(ConstantsPrefsKeys.loggedIn, true);
  }

  bool loggedIn() {
    return _sharedPreferences.getBool(ConstantsPrefsKeys.loggedIn).onNull();
  }

  void clear() {
    _sharedPreferences.clear();
  }

  String get locale =>
      _sharedPreferences.getString(ConstantsPrefsKeys.locale).parseToLocale();

  Future<void> setLocale(String locale) async {
    await _sharedPreferences.setString(ConstantsPrefsKeys.locale, locale);
  }

  Future<void> setAppTheme(String theme) async {
    await _sharedPreferences.setString(Constants.prefKeyTheme, theme);
  }

  String getAppTheme() {
    return _sharedPreferences.getString(Constants.prefKeyTheme).toString();
  }

  void setUserName(String name) async {
    await _sharedPreferences.setString(Constants.username, name);
  }

  String getUserName() {
    return _sharedPreferences.getString(Constants.username).onNull();
  }

  void setUserPhone(String phone) async {
    await _sharedPreferences.setString(Constants.phone, phone);
  }

  String getUserPhone() {
    return _sharedPreferences.getString(Constants.phone).onNull();
  }

  Future<void> setHasProfileData() async {
    await _sharedPreferences.setBool(Constants.hasProfileData, true);
  }

  bool getHasProfileData() {
    return _sharedPreferences.getBool(Constants.hasProfileData).onNull();
  }
}
