import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRichTextWidget extends StatelessWidget {
  const AppRichTextWidget({
    super.key,
    required this.textSpans,
    this.textAlign,
    this.maxLines = 1,
  });

  final List<InlineSpan> textSpans;
  final TextAlign? textAlign;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: context.textTheme.bodyMedium,
        children: textSpans,
      ),
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
