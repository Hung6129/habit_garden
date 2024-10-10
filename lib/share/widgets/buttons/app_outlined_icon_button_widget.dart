import 'package:flutter/material.dart';

import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/share/themes/app_theme.dart';
import 'app_icon_button_widget.dart';

class AppOutlinedIconButtonWidget extends StatelessWidget {
  const AppOutlinedIconButtonWidget(
      {super.key,
      required this.icon,
      required this.onPressed,
      this.size,
      this.iconColor,
      this.isLeading = false});

  final IconData icon;
  final double? size;
  final Color? iconColor;
  final bool isLeading;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (size ?? AppUIConstants.subButtonHeight) + 2,
      height: (size ?? AppUIConstants.subButtonHeight) + 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: iconColor ?? AppColors.get().primaryColor,
          width: 2,
        ),
      ),
      child: AppIconButtonWidget(
        icon: icon,
        onPressed: onPressed,
        size: size,
        iconColor: iconColor,
        isLeading: isLeading,
      ),
    );
  }
}
