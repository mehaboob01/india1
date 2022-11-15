import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  static SharedPreferences? _prefs;
  static SharedPreferences? _globalPrefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
    _globalPrefs = await SharedPreferences.getInstance();
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

  static gPutInteger(String key, int value) {
    if (_globalPrefs != null) _globalPrefs!.setInt(key, value);
  }

  static int gGetInteger(String key) {
    return _globalPrefs == null ? 0 : _globalPrefs!.getInt(key) ?? 0;
  }

  static gPutString(String key, String value) {
    if (_globalPrefs != null) _globalPrefs!.setString(key, value);
  }

  static String gGetString(String key) {
    return _globalPrefs == null ? '' : _globalPrefs!.getString(key) ?? "";
  }

  static gPutBool(String key, bool? value) async {
    if (_globalPrefs != null) _globalPrefs!.setBool(key, value!);
  }


  static bool? gGetBool(String key) {
    if (_globalPrefs == null) {
      return false;
    } else if (_globalPrefs!.getBool(key) == null) {
      return false;
    } else {
      return _globalPrefs!.getBool(key);
    }
  }

  static Future<bool> gClear() {
    return _globalPrefs!.clear();
  }



  static bool? checkUserExist(String key) {
    String strCustomerData = getString(key);
    if (strCustomerData.isEmpty || strCustomerData.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> clearUserData(String key) {
    return _prefs!.remove(key);
  }

// static Future<bool> putUserData(String key, ResponseUserData? userDTO) {
//   String encodedBusiness = json.encode(userDTO!.toJson());
//   return _prefs!.setString(key, encodedBusiness);
// }
//
// static ResponseUserData? getUserData(String key) {
//   String strCustomerData = getString(key);
//   if (strCustomerData.isEmpty || strCustomerData.length == 0) {
//     return null;
//   }
//
}
