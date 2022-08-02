import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PrefsService{

  static final String _key = "key";

  static save ({String? email, String? name}) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, jsonEncode({
      "email": email,
      "name": name,
      "isAuth": true
    })); // Transforma esse map em json

    var oqTem = prefs.getString(_key);
    var oqtem2 = jsonDecode(oqTem!);
    print("PRefs é: $oqtem2");
  }

  static Future<bool> isAuth() async {
    var prefs = await SharedPreferences.getInstance();
    var jsonResult = prefs.getString(_key);

    if(jsonResult != null){
      var mapUser = jsonDecode(jsonResult);
      return mapUser["isAuth"];
    }

    return false;
  }

  static logout() async{
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  // Pega nome do usuário logado atualmente.
   static Future<String> getName() async {
    var prefs = await SharedPreferences.getInstance();
    var jsonResult = prefs.getString(_key);
    if(jsonResult != null){
      var mapUser = await jsonDecode(jsonResult);
      return mapUser["name"];
    }
    return "SemNome";
  }
}