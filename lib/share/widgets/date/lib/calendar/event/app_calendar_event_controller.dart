import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/share/widgets/chip/app_chip_svg_widget.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';
import 'package:habit_garden/share/themes/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../app_date_picker_dialog.dart';

part 'app_calendar_event_state.dart';

part 'app_calendar_event_widget.dart';

class AppCalendarEventController extends GetxController {
  final AppCalendarEventState state = AppCalendarEventState();

  AppCalendarEventController(this.rangeStartDay, this.rangeEndDay);

  final DateTime? rangeStartDay;
  final DateTime? rangeEndDay;

  @override
  void onInit() {
    state.currentStartRangeSelected.value = rangeStartDay;
    state.currentEndRangeSelected.value = rangeEndDay;
    super.onInit();
  }

  void nextMonth(final DateTime? firstDate, final DateTime? lastDate) {
    final newDate = DateTime(
        state.currentDateFocus.value.year,
        state.currentDateFocus.value.month + 1,
        state.currentDateFocus.value.day);

    state.currentDateFocus.value =
        logicConvertDate(newDate, firstDate, lastDate);
  }

  void prevMonth(final DateTime? firstDate, final DateTime? lastDate) {
    final newDate = DateTime(
        state.currentDateFocus.value.year,
        state.currentDateFocus.value.month - 1,
        state.currentDateFocus.value.day);

    state.currentDateFocus.value =
        logicConvertDate(newDate, firstDate, lastDate);
  }

  DateTime logicConvertDate(final DateTime newDate, final DateTime? firstDate,
      final DateTime? lastDate) {
    if (firstDate != null || lastDate != null) {
      if (firstDate != null) {
        if (newDate.isBefore(firstDate)) {
          return firstDate;
        }
      }
      if (lastDate != null) {
        if (newDate.isAfter(lastDate)) {
          state.currentDateFocus.value = lastDate;
          return lastDate;
        }
      }
    }
    return newDate;
  }

  void onCalendarChange(DateTime dateTime) {
    state.currentDateFocus.value = dateTime;
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    state.currentStartRangeSelected.value = start;
    state.currentEndRangeSelected.value = end;
  }
}
