import 'package:flutter/material.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';
import 'package:habit_garden/share/themes/app_theme.dart';

class AppChipButtonWidget extends StatelessWidget {
  const AppChipButtonWidget({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onPressed,
  });

  final String text;
  final bool isSelected;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed?.call(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.get().neutralColor[0],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : AppColors.get().neutralColor[30]!),
        ),
        child: AppTextWidget(
          text,
          overflow: TextOverflow.ellipsis,
          textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : AppColors.get().neutralColor[80]),
        ),
      ),
    );
  }
}
