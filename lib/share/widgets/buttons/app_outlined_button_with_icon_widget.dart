import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';
import 'package:habit_garden/share/themes/app_theme.dart';

class AppOutlinedWithIconButtonWidget extends StatelessWidget {
  const AppOutlinedWithIconButtonWidget(
    this.text, {
    this.isEnable = true,
    this.onPressed,
    this.textStyle,
    required this.prefixIcon,
    this.borderColor,
    this.padding = const EdgeInsets.all(10),
    super.key,
  });

  final String text;
  final bool isEnable;
  final Widget prefixIcon;
  final TextStyle? textStyle;
  final Color? borderColor;
  final Function? onPressed;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnable ? () => onPressed?.call() : null,
      highlightColor: AppColors.get().successColor[5],
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: padding,
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
            SizedBox(width: 20, height: 20, child: prefixIcon),
            Expanded(
              child: AppTextWidget(
                text,
                textStyle: textStyle ??
                    context.textTheme.titleSmall?.copyWith(
                      color: isEnable
                          ? AppColors.get().neutralColor[100]
                          : AppColors.get().neutralColor[40]!,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
