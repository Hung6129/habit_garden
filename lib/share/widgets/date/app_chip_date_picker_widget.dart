import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/core/utils/date_utils.dart';
import 'package:habit_garden/share/widgets/app_icon_widget.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';
import 'package:habit_garden/share/themes/app_theme.dart';
import 'package:intl/intl.dart';

import 'lib/app_date_picker_dialog.dart';

class AppChipDatePickerWidget extends StatelessWidget {
  const AppChipDatePickerWidget({
    super.key,
    this.initValue,
    this.firstDate,
    this.lastDate,
    this.onChanged,
    this.isDefault = true,
  });

  final DateTime? initValue;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool isDefault;
  final Function(DateTime)? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
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
        debugPrint('Days between: $betweenDays');
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
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  width: 40,
                  height: 32,
                  alignment: Alignment.center,
                  child: AppIconWidget(
                    Icons.calendar_today,
                    iconSize: AppUIConstants.normalIconSizeInFarmerCard,
                    iconColor: context.theme.primaryColor,
                  ),
                ),
                if (!isDefault)
                  Positioned(
                    top: 6,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.get().errorColor,
                      ),
                      width: 8,
                      height: 8,
                    ),
                  )
              ],
            ),
            AppTextWidget(
              initValue != null
                  ? DateFormat(AppConstants.dateTimeDefaultFormat)
                      .format(initValue!)
                  : 'dd/mm/yyyy',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textStyle: context.textTheme.titleSmall
                  ?.copyWith(color: context.theme.appColor.primaryColor),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
