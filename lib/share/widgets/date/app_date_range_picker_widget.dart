import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/share/widgets/app_icon_widget.dart';
import 'package:habit_garden/share/widgets/date/lib/app_date_picker_dialog.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';
import 'package:habit_garden/share/themes/app_theme.dart';
import 'package:intl/intl.dart';

class AppDateRangePickerWidget extends StatelessWidget {
  const AppDateRangePickerWidget(
    this.label, {
    super.key,
    required this.hintText,
    this.onChanged,
    this.validator,
    this.initFirstDate,
    this.initLastDate,
    this.isRequired = false,
    this.isViewTextOnly = false,
    this.isDisabled = false,
    this.firstLimitDate,
    this.lastLimitDate,
  });

  final String label;
  final String hintText;
  final Function(DateTime?, DateTime?)? onChanged;
  final String? validator;
  final bool isDisabled;
  final bool isRequired;
  final bool isViewTextOnly;
  final DateTime? initFirstDate;
  final DateTime? initLastDate;
  final DateTime? firstLimitDate;
  final DateTime? lastLimitDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: AppTextWidget(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textStyle: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.get().neutralColor[60],
                ),
              ),
            ),
            if (isRequired && !isViewTextOnly) const SizedBox(width: 2),
            if (isRequired && !isViewTextOnly)
              AppTextWidget(
                '*',
                textStyle: context.textTheme.bodySmall
                    ?.copyWith(color: AppColors.get().errorColor),
              )
          ],
        ),
        InkWell(
          onTap: () async {
            if (isViewTextOnly || isDisabled) return;
            FocusScope.of(context).unfocus();
            AppDatePickerDialog.showDateRangePicker(
              context,
              initialFirstDate: initFirstDate,
              initialLastDate: initLastDate,
              firstLimitDate: firstLimitDate,
              lastLimitDate: lastLimitDate,
              onDateTimeChanged: (startDate, endDate) =>
                  onChanged?.call(startDate, endDate),
            );
          },
          child: isViewTextOnly
              ? Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 8),
                  child: AppTextWidget(
                    displayRangeDate(),
                    textStyle: (initFirstDate != null || initLastDate != null)
                        ? context.textTheme.bodyMedium
                        : context.textTheme.bodyMedium
                            ?.copyWith(color: context.theme.disabledColor),
                  ),
                )
              : InputDecorator(
                  decoration: InputDecoration(
                      errorText: validator,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.get().neutralColor[20]!),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.get().neutralColor[20]!),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: context.theme.primaryColor),
                      ),
                      contentPadding:
                          const EdgeInsets.only(top: 10, bottom: 12),
                      isDense: true,
                      suffixIcon: const AppIconWidget(Icons.calendar_today),
                      suffixIconConstraints: BoxConstraints(
                          minWidth: AppUIConstants.svgSize,
                          minHeight: AppUIConstants.svgSize)),
                  child: AppTextWidget(
                    displayRangeDate(),
                    textStyle: (initFirstDate != null || initLastDate != null)
                        ? context.textTheme.bodyMedium
                        : context.textTheme.bodyMedium
                            ?.copyWith(color: context.theme.hintColor),
                  ),
                ),
        ),
      ],
    );
  }

  String displayRangeDate() {
    if (initFirstDate == null && initLastDate == null) {
      return hintText;
    }
    return '${initFirstDate != null ? DateFormat(AppConstants.dateTimeDefaultFormat).format(initFirstDate!) : '--/--/----'} - ${initLastDate != null ? DateFormat(AppConstants.dateTimeDefaultFormat).format(initLastDate!) : '--/--/----'}';
  }
}
