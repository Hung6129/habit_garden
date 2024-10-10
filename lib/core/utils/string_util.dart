import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StringUtil {
  const StringUtil._();

  static String toFormatNumber(int index) {
    if (index > 0 && index < 10) {
      return '0$index';
    } else {
      return index.toString();
    }
  }

  static String formatDouble(double value) {
    if (value == value.roundToDouble()) {
      return value.round().toString();
    } else {
      return value.toString();
    }
  }

  static String formatDoubleAsFixed(double value) {
    int decimals = ((value - value.toInt()) != 0.0) ? 1 : 0;
    return value.toStringAsFixed(decimals);
  }

  static String generateRandomStringId(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  static String moneyDisplayForEdit(num money) {
    final formatCurrency =
        NumberFormat.currency(customPattern: '#,##0', decimalDigits: 0);
    return formatCurrency.format(money);
  }

  static String moneyDisplayWithSuffix(num money) {
    final formatCurrency =
        NumberFormat.currency(customPattern: '#,##0đ', decimalDigits: 0);
    return formatCurrency.format(money);
  }

  static String moneyDisplayForDouble(num money) {
    final formatCurrency =
        NumberFormat.currency(customPattern: '#,##0', decimalDigits: 2);
    return formatCurrency.format(money);
  }

  static String moneyDisplayWithSuffixForDouble(num money) {
    final formatCurrency =
        NumberFormat.currency(customPattern: '#,##0đ', decimalDigits: 2);
    return formatCurrency.format(money);
  }

  static double parseMoneyFromString(String value) {
    return NumberFormat.decimalPattern().parse(value).toDouble();
  }

  static String? verifyTotal(int total) {
    return total > 0 ? total.toString() : null;
  }

  static bool checkTheMatchingOfAddresses(String address1, String address2) {
    final simpleAddress1 = address1
        .toLowerCase()
        .toNonAccentVietnamese
        .replaceAll('-', "")
        .replaceAll('_', "")
        .replaceAll(',', "")
        .replaceAll('.', "")
        .replaceAll('tp ', "")
        .replaceAll('tt ', "")
        .replaceAll('tx ', "")
        .replaceAll('  ', " ");

    final simpleAddress2 = address2
        .toLowerCase()
        .toNonAccentVietnamese
        .replaceAll('-', "")
        .replaceAll('_', "")
        .replaceAll(',', "")
        .replaceAll('.', "")
        .replaceAll('tp ', "")
        .replaceAll('tt ', "")
        .replaceAll('tx ', "")
        .replaceAll('  ', " ");
    if (simpleAddress1.contains(simpleAddress2) ||
        simpleAddress2.contains(simpleAddress1)) {
      return true;
    }

    return false;
  }

  static num parseNumberFromAny(dynamic any_) {
    return num.tryParse(any_ != null ? '$any_'.replaceAll(',', '.') : '0') ??
        num.parse('0');
  }

  static String parseStringFromNullable(dynamic any) {
    return num.tryParse(any != null ? '$any' : '0').toString();
  }
}

extension StringExtensions on String {
  String get displayShortName {
    final components = split(' ');
    if (components.length > 1) {
      return components.first.substring(0, (min(1, components.first.length))) +
          components.last
              .substring(0, (min(1, components.last.length)))
              .toUpperCase();
    }
    return substring(0, (min(2, length))).toUpperCase();
  }

  double parseDoubleFromString() {
    return double.tryParse(replaceAll(',', '.')) ?? 0.0;
  }

  Color? toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return null;
  }

  bool get isHttps {
    return contains('http') == true || contains('https') == true;
  }

  String get toStringWithEmpty {
    return isNotEmpty ? this : '-';
  }

  String get toHidePhoneNumber {
    if (isEmpty || length - 4 < 0) return this;
    return '${substring(0, length - 4)}xxxx';
  }

  String get toPhoneShowOnOTP {
    if (isEmpty || length - 4 < 0) return this;
    return '******${substring(length - 4, length)}';
  }

  int get toInt {
    return int.tryParse(this) ?? 0;
  }

  String get toNonAccentVietnamese {
    return replaceAll(RegExp(r'A|Á|À|Ã|Ạ|Â|Ấ|Ầ|Ẫ|Ậ|Ă|Ắ|Ằ|Ẵ|Ặ'), "A")
        .replaceAll(RegExp(r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'), "a")
        .replaceAll(RegExp(r'E|É|È|Ẽ|Ẹ|Ê|Ế|Ề|Ễ|Ệ'), "E")
        .replaceAll(RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'), "e")
        .replaceAll(RegExp(r'I|Í|Ì|Ĩ|Ị'), "I")
        .replaceAll(RegExp(r'ì|í|ị|ỉ|ĩ'), "i")
        .replaceAll(RegExp(r'O|Ó|Ò|Õ|Ọ|Ô|Ố|Ồ|Ỗ|Ộ|Ơ|Ớ|Ờ|Ỡ|Ợ'), "O")
        .replaceAll(RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'), "o")
        .replaceAll(RegExp(r'U|Ú|Ù|Ũ|Ụ|Ư|Ứ|Ừ|Ữ|Ự'), "U")
        .replaceAll(RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'), "u")
        .replaceAll(RegExp(r'Y|Ý|Ỳ|Ỹ|Ỵ'), "Y")
        .replaceAll(RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'), "y")
        .replaceAll(RegExp(r'Đ'), "D")
        .replaceAll(RegExp(r'đ'), "d")
        .replaceAll(RegExp(r'\u0300|\u0301|\u0303|\u0309|\u0323'),
            "") /* Huyền sắc hỏi ngã nặng */
        .replaceAll(RegExp(r'\u02C6|\u0306|\u031B'), ""); // Â, Ê, Ă, Ơ, Ư
  }
}
