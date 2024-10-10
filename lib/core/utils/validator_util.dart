import 'package:email_validator/email_validator.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/core/translations/strings.dart';

import 'date_utils.dart';
import 'string_util.dart';

class ValidatorUtil {
  static String? requireValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Strings.requiredMessage;
    }
    return null;
  }

  static String? requireListValidator(List? value) {
    if (value == null || value.isEmpty) {
      return Strings.requiredMessage;
    }
    return null;
  }

  static String? requireQuantityNumberValidator(String? value) {
    if (value == null || value.isEmpty || double.tryParse(value) == 0) {
      return Strings.requiredMessage;
    }
    return null;
  }

  static String? requireNumberAndLargerZeroValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Strings.requiredMessage;
    }
    if (StringUtil.parseNumberFromAny(value).toDouble() == 0) {
      return Strings.requiredNumberLargerZeroMessage;
    }
    return null;
  }

  static String? requireDateValidator(DateTime? value) {
    return ValidatorUtil.requireValidator(
        value != null ? value.toString() : '');
  }

  static String? limitValidator(String? value, {required int min}) {
    if (requireValidator(value) != null) {
      return requireValidator(value);
    }
    if ((value?.length ?? 0) < min) {
      return '${Strings.limitMessage}. $min ký tự';
    }
    return null;
  }

  static String? limitNotRequireValidator(String? value, {required int min}) {
    if (value == null || value.trim().isEmpty) return null;
    if (value.length < min) {
      return '${Strings.limitMessage}. $min ký tự';
    }
    return null;
  }

  static String? limitCMNDValidator(String? value) {
    if (requireValidator(value) != null) {
      return requireValidator(value);
    }
    if ((value?.length ?? 0) != 9 && (value?.length ?? 0) != 12) {
      return Strings.limitCMNDMessage;
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (requireValidator(value) != null) {
      return requireValidator(value);
    }
    if (value!.length != AppConstants.phoneNumberLength ||
        value.substring(0, 1) != '0') {
      return Strings.phoneNumberValidate;
    }
    return null;
  }

  static bool validPhoneNumber(String? value) {
    if (value == null || value.length != 10 || value.substring(0, 1) != '0') {
      return false;
    }
    return true;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (!EmailValidator.validate(value)) {
      return Strings.emailInvalidMessage;
    }
    return null;
  }

  static String? compare2Date(
      DateTime? start, DateTime? end, String errorMessage) {
    if (start == null || end == null) {
      return Strings.requiredMessage;
    }
    if (DateUtil.daysBetween(start, end) < 0) {
      return errorMessage;
    }
    return null;
  }

  static String? dateFromDateValidator(
    DateTime? date,
    DateTime? dateToCompare,
    String errorMessage,
  ) {
    if (dateToCompare == null) {
      return null;
    }
    if (date == null) {
      return Strings.requiredMessage;
    }
    // the date must from the dateToCompare
    if (dateToCompare.compareTo(date) == 1) {
      return errorMessage;
    }
    return null;
  }

  static String? dateInPastValidator(DateTime? date, String errorMessage) {
    if (date == null) {
      return Strings.requiredMessage;
    }
    final now = DateTime.now();
    // the date must be in the past
    if (now.compareTo(date) != 1) {
      return errorMessage;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final sixCharsHasUpperLowerCaseAndNumber =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{6,}$');
    if (sixCharsHasUpperLowerCaseAndNumber.hasMatch(value)) {
      return null;
    }
    return Strings.passwordInvalidMessage;
  }

  static bool passwordValidatorCharAndNumber(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    // (?=.*[A-Z])
    final charAndNumber = RegExp(r'^(?=.*[a-z])(?=.*?[0-9])');
    return charAndNumber.hasMatch(value.toLowerCase());
  }

  static bool passwordValidatorSpecialChar(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    final specialChar = RegExp(r'^(?=.*?[!@#\$&*~])');
    return specialChar.hasMatch(value);
  }
}
