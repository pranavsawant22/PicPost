import 'package:shared_preferences/shared_preferences.dart';
class Helperfunction{
  static String UserNameKey = "usernamekey";

  static saveUserLogIn({bool isLoggedIn}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(UserNameKey,isLoggedIn);
  }
  static Future<bool>checkuserinfo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(UserNameKey);

  }
}