import 'package:aetherium_salon/utils/constant.dart';

class FunctionUtils {
  static int getHex(String hex) {
    return int.parse((hexPrefix + hex).replaceAll("#", ''));
  }
}
