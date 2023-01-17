import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  static SharedPreferences? _prefs;



  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static putInteger(String key, int value) {
    if (_prefs != null) _prefs!.setInt(key, value);
  }
  static String getString(String key) {
    return _prefs == null ? '' : _prefs!.getString(key) ?? "";
  }



  static int getInteger(String key) {
    return _prefs == null ? 0 : _prefs!.getInt(key) ?? 0;
  }

  static putString(String key, String value) {
    if (_prefs != null) _prefs!.setString(key, value);
  }



  static putBool(String key, bool value) {
    if (_prefs != null) _prefs!.setBool(key, value);
  }

  static bool getBool(String key) {
    return _prefs == null ? false : _prefs!.getBool(key) ?? false;
  }

  static Future<bool> clear() {
    return _prefs!.clear();
  }


  // static bool? checkUserExist(String key) {
  //   String strCustomerData = getString(key);
  //   if (strCustomerData.isEmpty || strCustomerData.length == 0) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  // static Future<bool> clearUserData(String key) {
  //   return _prefs!.remove(key);
  // }


}
