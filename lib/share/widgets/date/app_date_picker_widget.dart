import 'package:flutter/material.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/core/translations/strings.dart';
import 'package:habit_garden/core/utils/date_utils.dart';
import 'package:habit_garden/share/widgets/app_icon_widget.dart';
import 'package:habit_garden/share/widgets/date/lib/app_date_picker_dialog.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';
import 'package:habit_garden/share/themes/app_theme.dart';
import 'package:intl/intl.dart';

class AppDatePickerWidget extends StatelessWidget {
  const AppDatePickerWidget(
    this.label, {
    super.key,
    this.onChanged,
    this.isDisabled = false,
    this.validator,
    this.initValue,
    this.isRequired = false,
    this.isViewTextOnly = false,
    this.firstDate,
    this.lastDate,
  });

  final String label;
  final DateTime? initValue;
  final Function(DateTime)? onChanged;
  final String? validator;
  final bool isDisabled;
  final bool isRequired;
  final bool isViewTextOnly;
  final DateTime? firstDate;
  final DateTime? lastDate;

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
                textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.get().neutralColor[60],
                    ),
              ),
            ),
            if (isRequired) const SizedBox(width: 2),
            if (isRequired && !isViewTextOnly)
              AppTextWidget(
                '*',
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
              )
          ],
        ),
        InkWell(
          onTap: () {
            if (isViewTextOnly || isDisabled) return;
            FocusScope.of(context).unfocus();
            final first = firstDate != null
                ? DateTime(firstDate!.year, firstDate!.month, firstDate!.day)
                : null;
            final last = lastDate != null
                ? DateTime(lastDate!.year, lastDate!.month, lastDate!.day)
                : null;
            final init = initValue != null
                ? DateTime(initValue!.year, initValue!.month, initValue!.day)
                : (first ?? last);
            final betweenDays = init != null && first != null
                ? DateUtil.daysBetween(first, init)
                : 0;
            AppDatePickerDialog.showDatePicker(
              context,
              initialDate: betweenDays < 0 ? first : init,
              firstDate: first,
              lastDate: last,
              onDateTimeChanged: (selected) {
                if (selected != null) {
                  onChanged?.call(selected);
                }
              },
            );
          },
          child: isViewTextOnly
              ? Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 8),
                  child: AppTextWidget(
                    initValue != null
                        ? DateFormat(AppConstants.dateTimeDefaultFormat)
                            .format(initValue!)
                        : Strings.dateDefaultDisplayWhenNull,
                    textStyle: Theme.of(context).textTheme.bodyMedium,
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
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      contentPadding:
                          const EdgeInsets.only(top: 10, bottom: 12),
                      isDense: true,
                      suffixIcon: AppIconWidget(
                        Icons.calendar_today,
                        iconSize: AppUIConstants.svgSize,
                      ),
                      suffixIconConstraints: BoxConstraints(
                        minWidth: AppUIConstants.svgSize,
                        minHeight: AppUIConstants.svgSize,
                      )),
                  child: AppTextWidget(
                    initValue != null
                        ? DateFormat(AppConstants.dateTimeDefaultFormat)
                            .format(initValue ?? DateTime.now())
                        : Strings.chooseDate,
                    textStyle: initValue != null
                        ? Theme.of(context).textTheme.bodyMedium
                        : Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Theme.of(context).hintColor),
                  ),
                ),
        ),
      ],
    );
  }
}
