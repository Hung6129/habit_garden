import 'package:flutter/material.dart';

import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';
import 'package:habit_garden/share/themes/app_theme.dart';

enum ButtonSize { regular, small }

class AppFilledButtonWidget extends StatelessWidget {
  const AppFilledButtonWidget(
    this.text, {
    this.isEnable = true,
    this.onPressed,
    this.style,
    this.prefixIcon,
    this.textStyle,
    this.fillColor,
    this.buttonSize = ButtonSize.regular,
    this.wrapContent = false,
    super.key,
  });

  final String text;
  final bool isEnable;
  final Widget? prefixIcon;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final Function? onPressed;
  final Color? fillColor;
  final ButtonSize buttonSize;
  final bool wrapContent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnable ? () => onPressed?.call() : null,
      highlightColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: buttonSize == ButtonSize.regular
            ? const EdgeInsets.all(10)
            : const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: fillColor == null
              ? LinearGradient(
                  colors: [
                    isEnable
                        ? Theme.of(context).primaryColorLight
                        : Theme.of(context).disabledColor,
                    isEnable
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.clamp,
                )
              : null,
          color: fillColor,
        ),
        child: wrapContent
            ? Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppUIConstants.majorScalePadding(5),
                ),
                child: _buildText(context),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) prefixIcon!,
                  if (prefixIcon != null) const SizedBox(width: 12),
                  _buildText(context),
                ],
              ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return AppTextWidget(
      text,
      textAlign: TextAlign.center,
      textStyle: textStyle ??
          Theme.of(context).textTheme.titleSmall?.copyWith(
                color: isEnable
                    ? Theme.of(context).colorScheme.onPrimary
                    : AppColors.get().neutralColor[40],
              ),
    );
  }
}
