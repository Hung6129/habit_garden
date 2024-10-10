import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';
import 'package:intl/intl.dart';
import '../app_icon_widget.dart';

class AppChipCalendarWidget extends StatelessWidget {
  const AppChipCalendarWidget({
    super.key,
    required this.firstDate,
    required this.secondDate,
    this.isDot = false,
    this.onTap,
    this.borderRadius,
    this.border,
  });

  final DateTime firstDate;
  final DateTime? secondDate;

  final Function()? onTap;
  final bool isDot;
  final BorderRadius? borderRadius;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    final String renderDate =
        "${DateFormat(AppConstants.dateTimeDefaultFormat).format(firstDate)} ${secondDate != null ? ' - ${DateFormat(AppConstants.dateTimeDefaultFormat).format(secondDate!)}' : ''}";

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          border: border,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 40,
                  height: 32,
                  alignment: Alignment.center,
                  child: AppIconWidget(
                    // AppCustomIcons.calendar_today_filled,
                    Icons.calendar_today,
                    iconSize: AppUIConstants.normalIconSizeInFarmerCard,
                    iconColor: context.theme.primaryColor,
                  ),
                ),
                if (isDot)
                  Positioned(
                    top: 6,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.theme.colorScheme.error,
                      ),
                      width: 8,
                      height: 8,
                    ),
                  )
              ],
            ),
            AppTextWidget(
              renderDate,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textStyle: context.textTheme.titleMedium,
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
      ),
    );
  }
}
