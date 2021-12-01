import 'package:assignment/src/base_directory/base_get_controller.dart';
import 'package:assignment/src/home/ui/home_screen.dart';
import 'package:assignment/src/login/ui/login_screen.dart';
import 'package:assignment/src/preferences/app_preference.dart';
import 'package:assignment/src/util/utils.dart';
import 'package:assignment/src/login/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends BaseGetController {
  late Data? userInfo;
  late SharedPreferences preferences;

  void goToScreen() async {
    Future.delayed(Duration(seconds: 3), () async {
      if (AppPreferences.getUserID() != 0) {
        goToNextScreen(HomeScreen(), 'homeScreen');
      } else {
        goToNextScreen(LoginScreen(), 'loginScreen');
      }
    });
  }

  void sharePreferencesSetUp() async {
    preferences = await SharedPreferences.getInstance();
  }
}
