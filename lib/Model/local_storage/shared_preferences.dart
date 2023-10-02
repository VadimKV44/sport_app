import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static String url = "";

  static Future<bool> setUrl(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    url = url;
    return prefs.setString('url', url);
  }

  static Future<String> getUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    url = prefs.getString('url') ?? '';
    return url;
  }
}