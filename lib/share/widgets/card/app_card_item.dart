import 'package:flutter/material.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';
import 'package:habit_garden/share/themes/app_theme.dart';

class AppCartItemContentWithIcon extends StatelessWidget {
  const AppCartItemContentWithIcon({
    super.key,
    required this.icon,
    required this.content,
  });

  final Widget icon;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 4),
        Flexible(
          child: AppTextWidget(
            content.isNotEmpty ? content : '--',
            textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).appColor.neutralColor[80],
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
