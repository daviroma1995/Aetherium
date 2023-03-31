import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountInfoController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await profileImage();
  }

  RxString genderValue = 'Male'.obs;
  Rx<XFile?> imageUrl = XFile('').obs;
  RxBool isUpdating = false.obs;
  String imageFileString = '';
  final dateOfBirth = DateTime.now().obs;
  String get getDateOfBirth {
    final day = dateOfBirth.value.day < 10
        ? '0${dateOfBirth.value.day}'
        : dateOfBirth.value.day.toString();
    final month = dateOfBirth.value.month < 10
        ? '0${dateOfBirth.value.month}'
        : dateOfBirth.value.month.toString();
    return '$day/$month/${dateOfBirth.value.year}';
  }

  Future profileImage() async {
    final prefs = await SharedPreferences.getInstance();
    imageFileString = prefs.getString('profile_image') ?? '';
  }

  void changeValue(String value) {
    genderValue.value = value;
  }

  void loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      } else {
        imageUrl.value = image;
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('profile_image', image.path);
        isUpdating.value = true;
      }
    } catch (e) {
      print(e);
    }
  }
}
