import 'package:shared_preferences/shared_preferences.dart';
class Helperfunction{
  static String UserNameKey = "usernamekey";

  static Future<bool> saveUserLogIn({bool isLoggedIn}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(Helperfunction.UserNameKey,isLoggedIn);
  }
  static Future<bool>checkuserinfo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(Helperfunction.UserNameKey);

  }
}