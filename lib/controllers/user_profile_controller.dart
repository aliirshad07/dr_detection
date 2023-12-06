import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserProfileController extends GetxController {
  final GetStorage _box = GetStorage();

  RxString _firstName = ''.obs;
  RxString _lastName = ''.obs;
  RxString _emailAddress = ''.obs;
  RxString _gender = ''.obs;
  RxString _dob = ''.obs;

  String get firstName => _firstName.value;
  String get lastName => _lastName.value;
  String get emailAddress => _emailAddress.value;
  String get gender => _gender.value;
  String get dob => _dob.value;

  void setFirstName(String value) {
    _firstName.value = value;
  }

  void setLastName(String value) {
    _lastName.value = value;
  }

  void setEmailAddress(String value) {
    _emailAddress.value = value;
  }

  void setGender(String value) {
    _gender.value = value;
  }

  void setDob(String value) {
    _dob.value = value;
  }

  Future<void> saveUserProfileDetails() async {
    try {
      await _box.write('firstName', firstName);
      await _box.write('lastName', lastName);
      await _box.write('emailAddress', emailAddress);
      await _box.write('gender', gender);
      await _box.write('dob', dob);
    } catch (e) {
      print('Error saving user profile details: $e');
    }
  }

  Future<void> loadUserProfileDetails() async {
    try {
      _firstName.value = _box.read('firstName') ?? '';
      _lastName.value = _box.read('lastName') ?? '';
      _emailAddress.value = _box.read('emailAddress') ?? '';
      _gender.value = _box.read('gender') ?? '';
      _dob.value = _box.read('dob') ?? '';
    } catch (e) {
      print('Error loading user profile details: $e');
    }
  }
}
