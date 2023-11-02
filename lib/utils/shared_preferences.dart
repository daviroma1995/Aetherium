import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static final prefs = initialize();
  static bool _isLogedIn = false;
  static bool _showOnBoarding = true;
  static String _uid = '';
  static String _imageUrlString = '';
  static Future<void> loadData() async {
    var prefs = await SharedPreferences.getInstance();
    _isLogedIn = prefs.getBool('isLogedIn') ?? false;
    _showOnBoarding = prefs.getBool('showOnBoarding') ?? true;
    _uid = prefs.getString('uid') ?? '';
    _imageUrlString = prefs.getString('imageUrlString') ?? '';
  }

  static Future<void> resetData() async {
    setIsLogedIn(false);
    setUid('');
    setImageUrlString('');
  }

  static Future<SharedPreferences> initialize() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static void setUid(String uid) async {
    var prefs = await initialize();
    prefs.setString('uid', uid);
    _uid = uid;
  }

  static void setSwhowOnBoarding(bool showonBoarding) async {
    var prefs = await initialize();
    prefs.setBool('showOnBoarding', showonBoarding);
    _showOnBoarding = showonBoarding;
  }

  static void setIsLogedIn(bool isLogedIn) async {
    var prefs = await initialize();
    prefs.setBool('isLogedIn', isLogedIn);
    _isLogedIn = isLogedIn;
  }

  static void setImageUrlString(String url) async {
    var prefs = await initialize();
    prefs.setString('imageUrlString', url);
    _imageUrlString = url;
  }

  static bool get isLogedIn {
    return _isLogedIn;
  }

  static String get uid {
    return _uid;
  }

  static bool get showOnBoarding {
    return _showOnBoarding;
  }

  static String get imageUrlString {
    return _imageUrlString;
  }
}
