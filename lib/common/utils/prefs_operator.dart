
import 'package:shared_preferences/shared_preferences.dart';
import '../../locator.dart';

class PrefsOperator {
  late SharedPreferences sharedPreferences;
  PrefsOperator() {
    sharedPreferences = locator<SharedPreferences>();
  }


  saveUserData(token, userName, mobile) async {
    sharedPreferences.setString("user_token", token);
    sharedPreferences.setString("user_name", userName);
    sharedPreferences.setString("user_mobile", mobile);
    sharedPreferences.setBool("loggedIn", true);
  }

  getUserToken() async {
    final String? userToken = sharedPreferences.getString('user_token');
    return userToken;
  }

  changeIntroState() async {
    sharedPreferences.setBool("showIntro", false);
  }

  Future<bool> getIntroState() async {
    return sharedPreferences.getBool("showIntro") ?? true;
  }

  Future<bool> getLoggedIn() async {
    return sharedPreferences.getBool("loggedIn") ?? false;
  }

  Future<void> logout() async {
    sharedPreferences.clear();
    sharedPreferences.setBool("showIntro", false);
  }

}