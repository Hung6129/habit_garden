part of 'app_calendar_event_controller.dart';

class AppCalendarEventWidget extends StatelessWidget {
  const AppCalendarEventWidget({
    super.key,
    this.daysWithMarker,
    this.onRangeSelected,
    this.initRangeStartDay,
    this.initRangeEndDay,
    this.firstDay,
    this.lastDay,
  });

  final List<DateTime>? daysWithMarker;
  final OnRangeSelected? onRangeSelected;
  final DateTime? initRangeStartDay;
  final DateTime? initRangeEndDay;
  final DateTime? firstDay;
  final DateTime? lastDay;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppCalendarEventController>(
        init: AppCalendarEventController(initRangeStartDay, initRangeEndDay),
        builder: (controller) {
          controller.state.currentDateFocus.value =
              initRangeEndDay ?? firstDay ?? lastDay ?? DateTime.now();
          return Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: context.theme.dividerColor, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: InkWell(
                      onTap: () {
                        AppDatePickerDialog.showMonthPicker(
                          context,
                          initialDate: controller.state.currentDateFocus.value,
                          onDateTimeChanged: (selected) {
                            if (selected != null) {
                              controller.state.currentDateFocus.value =
                                  selected;
                            }
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Obx(
                            () {
                              var month = DateFormat(
                                      AppConstants.dateTimeCalendarEventFormat,
                                      'vi_VN')
                                  .format(
                                      controller.state.currentDateFocus.value);
                              return AppTextWidget(
                                month.substring(0, 1).toUpperCase() +
                                    month.substring(1, month.length),
                                textStyle: context.theme.textTheme.titleSmall,
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_drop_down_sharp),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  AppChipSvgWidget(
                    icon: const Icon(Icons.keyboard_arrow_left_outlined),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    border:
                        Border.all(color: context.theme.dividerColor, width: 1),
                    onTap: () => controller.prevMonth(firstDay, lastDay),
                  ),
                  AppChipSvgWidget(
                    icon: const Icon(Icons.keyboard_arrow_right_outlined),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    border:
                        Border.all(color: context.theme.dividerColor, width: 1),
                    onTap: () => controller.nextMonth(firstDay, lastDay),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(
                () {
                  return TableCalendar(
                      locale: 'vi_VN',
                      rowHeight: 40,
                      daysOfWeekHeight: 40,
                      pageJumpingEnabled: true,
                      onPageChanged: (dateTime) {
                        controller.onCalendarChange(dateTime);
                      },
                      pageAnimationEnabled: false,
                      firstDay: firstDay ?? DateTime.utc(2010, 10, 16),
                      lastDay: lastDay ?? DateTime.utc(2030, 3, 14),
                      rangeStartDay:
                          controller.state.currentStartRangeSelected.value,
                      rangeEndDay:
                          controller.state.currentEndRangeSelected.value,
                      focusedDay: controller.state.currentDateFocus.value,
                      selectedDayPredicate: (DateTime day) {
                        var selected =
                            controller.state.currentStartRangeSelected.value;
                        return selected?.year == day.year &&
                            selected?.month == day.month &&
                            selected?.day == day.day;
                      },
                      headerVisible: false,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      availableGestures: AvailableGestures.none,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        dowTextFormatter: (date, locale) =>
                            DateFormat.E(locale).format(date).toUpperCase(),
                        weekdayStyle: context.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        weekendStyle: context.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: true,
                        rangeHighlightScale: 1,
                        cellMargin: const EdgeInsets.all(0),
                        rangeHighlightColor:
                            context.theme.appColor.successColor[5]!,
                        todayTextStyle: context.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: context.theme.appColor.primaryColor,
                        ),
                        todayDecoration: BoxDecoration(
                          border: Border.all(
                              color: context.theme.primaryColor, width: 1),
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle:
                            context.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.theme.appColor.neutralColor[0],
                        ),
                        selectedDecoration: BoxDecoration(
                          color: context.theme.appColor.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        rangeStartTextStyle:
                            context.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.theme.appColor.neutralColor[0],
                        ),
                        rangeStartDecoration: BoxDecoration(
                          color: context.theme.appColor.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        rangeEndTextStyle:
                            context.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.theme.appColor.neutralColor[0],
                        ),
                        rangeEndDecoration: BoxDecoration(
                          color: context.theme.appColor.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        defaultTextStyle: context.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        withinRangeTextStyle:
                            context.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        markerSize: 4,
                        markersAnchor: 3,
                        markerDecoration: BoxDecoration(
                          color: context.theme.appColor.errorColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      rangeSelectionMode: RangeSelectionMode.toggledOn,
                      onRangeSelected: (DateTime? start, DateTime? end,
                          DateTime focusedDay) {
                        controller.onRangeSelected(start, end, focusedDay);
                        if (onRangeSelected != null) {
                          onRangeSelected!(start, end, focusedDay);
                        }
                      },
                      eventLoader: (DateTime day) {
                        if (daysWithMarker?.isEmpty == true) {
                          return [];
                        }
                        if (daysWithMarker?.where((element) {
                              return element.year == day.year &&
                                  element.month == day.month &&
                                  element.day == day.day;
                            }).isNotEmpty ==
                            true) {
                          return [''];
                        }
                        return [];
                      });
                },
              ),
            ],
          );
        });
  }
}
