import 'regexp_helper.dart';

class FormValidators {
  static String? validateName(String? value) {
    if (!value!.contains(RegexHelper.wordsOnlyRegex)) {
      return 'Enter Valid Name';
    }
    return null;
  }

  static String? validateNationalityIsEmpty(String? value) {
    if (value == null) {
      return 'Select your Nationality';
    }
    return null;
  }

  static String? validateRelationIsEmpty(int? value) {
    if (value == null) {
      return 'Select your Nationality';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (!value!.contains(RegexHelper.phoneNoRegex)) {
      return 'Enter Valid Phone Number';
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (value!.isEmpty) {
      return "Please Enter your Kid's Date of Birth";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    // if (email!.contains('@') && email.contains('.com')) {
    if (!value!.contains(RegexHelper.emailRegex)) {
      return 'Enter Valid Email';
    }
    return null;
  }
}
