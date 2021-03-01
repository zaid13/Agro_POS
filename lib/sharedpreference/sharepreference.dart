



import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefence{

  static String id = 'id_agro';
  static   adduser(String userid) async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(id, userid);



  }
  static   removeUser(String userid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.get(id);

  }
  static Future<String> getUserFromPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(id);

  }
}