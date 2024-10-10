import 'package:flutter/material.dart';

class AppTextWidget extends StatelessWidget {
  const AppTextWidget(
    this.text, {
    this.textStyle,
    this.textAlign,
    this.maxLines,
    this.overflow,
    super.key,
  });

  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
