part of 'app_calendar_event_controller.dart';

class AppCalendarEventState {
  AppCalendarEventState();

  Rx<DateTime> currentDateFocus = Rx(DateTime.now());
  Rx<DateTime?> currentStartRangeSelected = Rx(DateTime.now());
  Rx<DateTime?> currentEndRangeSelected = Rx(DateTime.now());
}