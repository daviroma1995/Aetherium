import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  late SharedPreferences prefs;

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  static const _skipWalkthrough = "skipWalkthrough";

  static Future<void> setSkipWalkthrough(bool walkthroughSeen) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_skipWalkthrough, walkthroughSeen);
  }

  static Future<bool> getSkipWalkthrough() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_skipWalkthrough) ?? false;
  }
}
