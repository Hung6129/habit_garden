import 'package:flutter/material.dart';

import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';

class AppTextButtonWidget extends StatelessWidget {
  const AppTextButtonWidget(this.text,
      {this.isEnable = true,
      this.onPressed,
      this.style,
      this.textStyle,
      super.key});

  final String text;
  final bool isEnable;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isEnable ? () => onPressed?.call() : null,
      style: style ?? Theme.of(context).textButtonTheme.style,
      child: AppTextWidget(
        text,
        textAlign: TextAlign.center,
        textStyle: textStyle ??
            Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
      ),
    );
  }
}
