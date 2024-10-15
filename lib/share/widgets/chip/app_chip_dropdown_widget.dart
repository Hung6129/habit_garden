import 'package:flutter/material.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';
import 'package:habit_garden/share/themes/app_theme.dart';

class AppChipDropdownWidget extends StatelessWidget {
  const AppChipDropdownWidget({
    super.key,
    required this.hint,
    this.isSelected = false,
    this.onPressed,
  });

  final String hint;
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
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: AppTextWidget(
                hint,
                overflow: TextOverflow.ellipsis,
                textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : AppColors.get().neutralColor[80]),
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.arrow_drop_down,
                size: 18,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : AppColors.get().neutralColor[80])
          ],
        ),
      ),
    );
  }
}
