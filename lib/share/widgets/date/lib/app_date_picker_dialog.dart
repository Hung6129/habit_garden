import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/core/translations/strings.dart';
import 'package:habit_garden/share/widgets/buttons/app_text_button_widget.dart';
import 'package:habit_garden/share/themes/app_theme.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'calendar/event/app_calendar_event_controller.dart';

class AppDatePickerDialog {
  AppDatePickerDialog._();
  static const durationYears = Duration(days: 10 * 365); /* 10 yrs*/
  static DateTime defaultFirstDate = DateTime.now().subtract(durationYears);
  static DateTime defaultLastDate = DateTime.now().add(durationYears);

  static void showMonthPicker(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    required Function(DateTime?) onDateTimeChanged,
  }) async {
    final selectedValue = await showMonthYearPicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? defaultFirstDate,
      lastDate: lastDate ?? defaultLastDate,
      initialMonthYearPickerMode: MonthYearPickerMode.month,
      builder: ((context, child) => Theme(
            data: Theme.of(context).copyWith(
              textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                  textStyle: WidgetStateProperty.all<TextStyle>(
                    Theme.of(context).textTheme.titleSmall!,
                  ),
                  foregroundColor: WidgetStateProperty.all<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: Theme.of(context).scaffoldBackgroundColor,
                    onPrimary: AppColors.get().neutralColor,
                    secondary: Theme.of(context).primaryColor,
                    onSecondary: Theme.of(context).scaffoldBackgroundColor,
                  ),
              dialogTheme: DialogTheme(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            child: Container(
              child: child,
            ),
          )),
    );
    if (DateUtils.isSameDay(selectedValue, initialDate) ||
        selectedValue == null) return;
    onDateTimeChanged(selectedValue);
  }

  static void showDatePicker(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    required Function(DateTime?) onDateTimeChanged,
  }) async {
    var selectedAndroid = await showRoundedDatePicker(
      context: context,
      theme: Theme.of(context).copyWith(
        primaryColor: Theme.of(context).appColor.neutralColor[0],
      ),
      styleYearPicker: MaterialRoundedYearPickerStyle(
        textStyleYear: Theme.of(context).textTheme.bodyMedium,
        textStyleYearSelected: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Theme.of(context).appColor.primaryColor),
      ),
      styleDatePicker: MaterialRoundedDatePickerStyle(
        paddingDateYearHeader:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        textStyleDayButton: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).appColor.primaryColor,
              fontSize: 32,
            ),
        textStyleYearButton: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).appColor.neutralColor[100],
            ),
        textStyleMonthYearHeader: Theme.of(context).textTheme.titleSmall,
        paddingMonthHeader: const EdgeInsets.symmetric(vertical: 12),
        textStyleDayHeader: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
            ),
        textStyleDayOnCalendarDisabled:
            Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).appColor.neutralColor[20],
                ),
        textStyleButtonPositive: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: Theme.of(context).appColor.primaryColor),
        textStyleButtonNegative: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: Theme.of(context).appColor.primaryColor),
      ),
      builderDay: (DateTime dateTime, bool isCurrentDay, bool isSelected,
          TextStyle defaultTextStyle) {
        if (isSelected) {
          return Container(
            decoration: BoxDecoration(
                color: Theme.of(context).appColor.primaryColor,
                shape: BoxShape.circle),
            child: Center(
              child: Text(
                dateTime.day.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).appColor.neutralColor[0],
                    ),
              ),
            ),
          );
        }
        if (isCurrentDay) {
          return Container(
            decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 1),
                shape: BoxShape.circle),
            child: Center(
              child: Text(
                dateTime.day.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).appColor.primaryColor,
                    ),
              ),
            ),
          );
        }
        return Center(
          child: Text(
            dateTime.day.toString(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w400, color: defaultTextStyle.color),
          ),
        );
      },
      textNegativeButton: Strings.exit,
      textPositiveButton: Strings.confirm,
      height: MediaQuery.of(context).size.height * 0.5,
      borderRadius: 16,
      initialDate: initialDate,
      firstDate:
          firstDate ?? initialDate?.subtract(durationYears) ?? defaultFirstDate,
      lastDate: lastDate ?? initialDate?.add(durationYears) ?? defaultLastDate,
    );
    onDateTimeChanged(selectedAndroid);
  }

  static void showDateRangePicker(
    BuildContext? context, {
    DateTime? initialFirstDate,
    DateTime? initialLastDate,
    DateTime? firstLimitDate,
    DateTime? lastLimitDate,
    required Function(DateTime?, DateTime?) onDateTimeChanged,
  }) async {
    if (context == null) return;
    DateTime? firstDate, lastDate;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppCalendarEventWidget(
                  initRangeStartDay: initialFirstDate,
                  initRangeEndDay: initialLastDate,
                  firstDay: firstLimitDate,
                  lastDay: lastLimitDate,
                  daysWithMarker: List.empty(),
                  onRangeSelected:
                      (DateTime? start, DateTime? end, DateTime focusedDay) {
                    firstDate = start;
                    lastDate = end;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppUIConstants.defaultPadding),
                  child: const Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppTextButtonWidget(
                      Strings.exit,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    AppTextButtonWidget(
                      Strings.confirm,
                      onPressed: () => {
                        Navigator.of(context).pop(),
                        onDateTimeChanged.call(firstDate, lastDate),
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
