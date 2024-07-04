import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._ctor();

  factory SharedPreferencesHelper() {
    return _instance;
  }

  SharedPreferencesHelper._ctor();
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void setcustomerId({required String customerId}) {
    _prefs.setString("customerId", customerId);
  }

  static String getcustomerId() {
    return _prefs.getString("customerId") ?? "";
  }

  static void cleanUser() {
    _prefs.clear();
  }
}
