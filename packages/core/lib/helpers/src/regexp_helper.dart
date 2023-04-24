class RegexHelper {
  static RegExp finalPin = RegExp('[^0-9]');
  static RegExp emailRegex = RegExp(r'\w+@\w+\.\w+');
  static RegExp phoneNoRegex = RegExp(r'\d{9}');
  static RegExp wordsOnlyRegex = RegExp(r'\w+');
}
