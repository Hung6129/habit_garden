import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:intl/intl.dart';

class DateUtil {
  const DateUtil._();

  static String? formatDateRequest(DateTime? value) {
    return value != null
        ? DateFormat(AppConstants.dateTimeRequestFormat).format(value)
        : null;
  }

  static String? formatTimeRequest(DateTime? value) {
    return value != null
        ? DateFormat(AppConstants.timeRequestFormat).format(value)
        : null;
  }

  static String? formatDisplayDate(DateTime? value) {
    return value != null
        ? DateFormat(AppConstants.dateTimeDefaultFormat).format(value)
        : null;
  }

  static bool isTheSameDate(DateTime? dateTime1, DateTime? dateTime2) {
    return dateTime1?.day == dateTime2?.day &&
        dateTime1?.month == dateTime2?.month &&
        dateTime1?.year == dateTime2?.year;
  }

  static bool isTheSameTime(DateTime? dateTime1, DateTime? dateTime2) {
    return dateTime1?.hour == dateTime2?.hour;
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  static String formatDateTimeNotification(DateTime? value) {
    return value != null
        ? DateFormat(AppConstants.dateTimeNotificationFormat).format(value)
        : '--';
  }

  static String formatHistoryDate(DateTime? value) {
    return value != null
        ? DateFormat(AppConstants.dateTimeHistoryFormat).format(value)
        : '--';
  }

  // static String? formatDisplayTime(TimeOfDay? timeOfDay) {
  //   if (timeOfDay == null || Get.context == null) return null;

  //   return timeOfDay.format(Get.context!);
  // }

  static DateTime mostRecentMonday(DateTime date) =>
      DateTime(date.year, date.month, date.day - (date.weekday - 1));

  static DateTime mostRecentSunday(DateTime date) =>
      DateTime(date.year, date.month, date.day + (7 - date.weekday));

  static DateTime? dateFromString(String? dateString) {
    if (dateString != null && dateString.isNotEmpty) {
      return DateTime.tryParse(dateString);
    }
    return null;
  }

  static String formattedCountDownTime(int timeInSecond) {
    int hr = (timeInSecond / (60 * 60)).floor();
    int min = ((timeInSecond - hr * (60 * 60)) / 60).floor();
    int sec = (timeInSecond - hr * (60 * 60)) % 60;

    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    if (min == 0 && hr == 0) {
      return second;
    }
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    if (hr == 0) {
      return "$minute:$second";
    }
    String hour = hr.toString().length <= 1 ? "0$hr" : "$hr";
    return "$hour:$minute:$second";
  }

  static DateTime minDates(List<DateTime> list) {
    DateTime minDate = list.first;
    int minDayBetween = 0;
    for (var date in list) {
      final day = daysBetween(minDate, date);
      if (day < minDayBetween) {
        minDate = date;
        minDayBetween = day;
      }
    }
    return minDate;
  }

  // Count time
  static String diffTime(DateTime from, DateTime to) {
    final diff = to.difference(from);

    if (diff.inMinutes < 60) return '${diff.inMinutes} phút trước';
    if (diff.inHours < 24) return '${diff.inHours} giờ trước';
    if (diff.inDays < 7) return '${diff.inDays} ngày trước';
    return formatDisplayDate(from) ?? '--';
  }
}

extension DateUtilExtension on DateTime {
  plusDays(int day_) => add(Duration(days: day_));

  subtractDays(int day_) => subtract(Duration(days: day_));

  subtractYears(int years_) => subtract(Duration(days: years_ * 365));

  bool checkDateTimeInRange({DateTime? from, DateTime? to}) {
    if (from == null) return true;
    if (to == null) {
      return difference(from).inHours >= 0 && difference(from).inHours <= 24;
    }
    return difference(from).inSeconds >= 0 && difference(to).inSeconds <= 0;
  }
}
