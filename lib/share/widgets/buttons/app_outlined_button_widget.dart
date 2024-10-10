import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';
import 'package:habit_garden/share/themes/app_theme.dart';

class AppOutlinedButtonWidget extends StatelessWidget {
  const AppOutlinedButtonWidget(this.text,
      {this.isEnable = true,
      this.onPressed,
      this.textStyle,
      this.prefixIcon,
      this.prefixIconPadding,
      this.borderColor,
      super.key});

  final String text;
  final bool isEnable;
  final Widget? prefixIcon;
  final double? prefixIconPadding;
  final TextStyle? textStyle;
  final Color? borderColor;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnable ? () => onPressed?.call() : null,
      highlightColor: AppColors.get().successColor[5],
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.get().neutralColor[0],
          border: Border.all(
            width: 1,
            color: borderColor ??
                (isEnable
                    ? AppColors.get().neutralColor[30]!
                    : context.theme.disabledColor),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null) prefixIcon!,
            if (prefixIcon != null)
              SizedBox(
                width: prefixIconPadding ?? AppUIConstants.majorScalePadding(3),
              ),
            AppTextWidget(
              text,
              textStyle: textStyle ??
                  context.textTheme.titleSmall?.copyWith(
                    color: isEnable
                        ? context.theme.primaryColor
                        : AppColors.get().neutralColor[40]!,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
