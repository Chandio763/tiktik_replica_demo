
import 'app_string.dart';

class AppValidations {
  static const _passwordMinLen8WithNumbers =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$';

  static const String _emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const _numberPattern = r'^[0-9]*$';
  static const _namePattern = r'^[a-z A-Z]+$';
static const _alphanumericPattern = r'^[a-zA-Z0-9]*$';

  static const _usernamePattern =
      r'^(?=.*[a-zA-Z])[a-zA-Z0-9][a-zA-Z0-9_]*[a-zA-Z0-9]$';

  static bool _isEmailValid(String email) {
    final regexEmail = RegExp(_emailPattern);
    return regexEmail.hasMatch(email);
  }

  static bool _isnameValid(String name) {
    final regexName = RegExp(_namePattern);
    return regexName.hasMatch(name);
  }

  static bool _isUserNameValid(String name) {
    final regexName = RegExp(_usernamePattern);
    return regexName.hasMatch(name);
  }

  static bool _isNumberValid(String number) {
    final regexPhone = RegExp(_alphanumericPattern);
    return regexPhone.hasMatch(number);
  }

  static bool _isPasswordValid(String password, String pattern) {
    final regexPassword = RegExp(pattern);
    return regexPassword.hasMatch(password);
  }

  static String? validateEmail(
    String email, {
    String? errorMessage,
    String? emptyErrorMessage,
    String? fieldName,
  }) {
    if (email.isEmpty) {
      return emptyErrorMessage ?? AppString.errorThisFieldCantBeEmpty;
    } else if (_isEmailValid(email)) {
      return null;
    } else {
      return errorMessage ?? AppString.errorInvalidEmail;
    }
  }

  static String? validatePassword(String password,
      {String? errorMessage, String? fieldName, String? emptyErrorMessage}) {
    if (password.isEmpty) {
      return emptyErrorMessage ?? AppString.errorThisFieldCantBeEmpty;
    } else if (_isPasswordValid(password, _passwordMinLen8WithNumbers)) {
      return null;
    } else {
      return errorMessage ?? AppString.errorInvalidPassword;
    }
  }

  static String? validatePhone(String number,
      {String? errorMessage, String? fieldName}) {
    if (_isNumberValid(number) == true && number.length == 10) {
      return null;
    } else if (number.length >= 0 && number.length != 10) {
      return errorMessage ?? AppString.errorInvalidPhoneNumber;
    } else {
      return null;
    }
  }

  static String? validatePrice(
    String name, {
    String? errorMessage,
  }) {
    final num = name.isNotEmpty ? double.parse(name) : 0;
    if (name.isEmpty) {
      return AppString.errorThisFieldCantBeEmpty;
    } else if (num < 1) {
      return errorMessage;
    } else {
      return null;
    }
  }

  static String? validateName(
    String name, {
    String? errorMessage,
    String? emptyErrorMessage,
    String? fieldName,
  }) {
    if (name.isEmpty) {
      return emptyErrorMessage ?? AppString.errorThisFieldCantBeEmpty;
    } else if (_isnameValid(name)) {
      return null;
    } else {
      return errorMessage ?? AppString.pleaseEnterValidName;
    }
  }

  String? minimumSalaryValidation(
      String? minimumSalary, String? maximumSalary) {
    if (minimumSalary == null || minimumSalary.isEmpty) {
      return 'Please enter salary';
    }
    final minSalary = int.tryParse(minimumSalary);
    if (minSalary == null) {
      return 'Please enter valid salary';
    }
    if (minSalary < 40000) {
      return 'should be at least Ksh 40,000';
    }
    if (minSalary > 200000) {
      return 'should not exceed Ksh 200,000';
    }
    return null;
  }

  String? maximumSalaryValidation(
      String? minimumSalary, String? maximumSalary) {
    if (maximumSalary == null || maximumSalary.isEmpty) {
      return 'Please enter salary';
    }
    final maxSalary = int.tryParse(maximumSalary);
    final minSalary = int.tryParse(minimumSalary ?? '');
    if (maxSalary == null) {
      return 'Please enter the valid salary';
    }
    if (maxSalary == minSalary) {
      return 'Minimum salary cannot be equal to maximum salary';
    }
    if (minSalary != null && maxSalary < minSalary) {
      return 'Maximum salary cannot be less than minimum salary';
    }
    if (maxSalary < 40000) {
      return 'should be at least Ksh 40,000';
    }
    if (maxSalary > 200000) {
      return 'should not exceed Ksh 200,000';
    }
    return null;
  }

  static String? validateEmptyField(
    String controller, {
    String? errorMessage,
    String? fieldName,
  }) {
    if (controller.isEmpty) {
      return errorMessage ??
          "${fieldName ?? 'This field'} ${AppString.cantBeEmpty}";
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(
      {String? password,
      String? confirmPass,
      String? errorMessage,
      String? confirmPasswordMessage}) {
    if (password!.isEmpty) {
      return AppString.errorThisFieldCantBeEmpty;
    } else if (confirmPass != password) {
      return confirmPasswordMessage!;
    } else {
      return null;
    }
  }
  static String? validateIDNumber(
    String idNumber, {
    String? errorMessage,
    String? emptyErrorMessage,
    String? fieldName,
  }) {
    if (idNumber.isEmpty) {
      return emptyErrorMessage ?? AppString.errorThisFieldCantBeEmpty;
    } else if (_isNumberValid(idNumber)) {
      return null;
    } else {
      return errorMessage ?? AppString.errorInvalidID;
    }
  }
   static String? validateDropdown(String? value, {required String errorMessage}) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }
  static String? validPin(String? value,String newPinController){
        if (value == null || value.isEmpty) {
                return AppString.pinRequired;
              }
              if (value != newPinController) {
                return AppString.newPinSameAsCurrent;
              }
              return null;

  }
}
