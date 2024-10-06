class StringValidation {
  //check if a string contains uppercase letter
  static bool containsUpperCase(String value) {
    return value.contains(RegExp(r'[A-Z]'));
  }

  //check if a string contains lowercase letter
  static bool containsLowerCase(String value) {
    return value.contains(RegExp(r'[a-z]'));
  }

  //check if a string contains a number
  static bool containsNumber(String value) {
    return value.contains(RegExp(r'[0-9]'));
  }

  //check if a string contains a special character
  static bool containsSpecialCharacter(String value) {
    return value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>-]'));
  }
}
