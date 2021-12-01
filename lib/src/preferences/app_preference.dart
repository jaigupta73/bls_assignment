import 'package:assignment/src/app_secret_config/app_secret_config.dart';
import 'package:assignment/src/preferences/preference_tags.dart';

class AppPreferences {
  static setUserID(int userID) {
    AppSecretConfig.instance.preferences.setInt(PreferenceTags.USER_ID, userID);
  }

  static int getUserID() {
    return AppSecretConfig.instance.preferences.getInt(PreferenceTags.USER_ID) ?? 0;
  }

  static String getLanguageCode() {
    String? lang = AppSecretConfig.instance.preferences.getString(PreferenceTags.LANGUAGE_CODE);
    return lang != null && lang.isNotEmpty ? lang : 'en';
  }

  static void setLanguageCode(String code) {
    AppSecretConfig.instance.preferences.setString(PreferenceTags.LANGUAGE_CODE, code);
  }
}
