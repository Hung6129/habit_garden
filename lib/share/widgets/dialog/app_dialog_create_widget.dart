import 'package:flutter/material.dart';

import 'package:habit_garden/share/widgets/buttons/app_filled_button_widget.dart';
import 'package:habit_garden/share/widgets/buttons/app_outlined_button_widget.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';

class AppDialogCreateWidget {
  const AppDialogCreateWidget({
    required this.title,
    required this.positiveText,
    this.negativeText,
    this.subText,
    this.subWidget,
    this.onNegativeFunc,
    this.onPositiveFunc,
    this.barrierDismissible = false,
    this.positiveButtonColor,
    this.customActions,
  });

  final bool? barrierDismissible;
  final String title;
  final String? subText, negativeText;
  final Function? onNegativeFunc, onPositiveFunc;
  final Widget? subWidget;
  final String positiveText;
  final Color? positiveButtonColor;
  final Widget? customActions;

  Dialog showDialog(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextWidget(
              title,
              textStyle: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            if (subText?.isNotEmpty == true)
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.5),
                child: AppTextWidget(
                  subText!,
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            if (subWidget != null) subWidget!,
            const SizedBox(height: 24),
            customActions ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (negativeText?.isNotEmpty == true)
                      Expanded(
                        child: AppOutlinedButtonWidget(
                          negativeText ?? '',
                          onPressed: onNegativeFunc != null
                              ? () => onNegativeFunc?.call()
                              : () => Navigator.pop(context),
                        ),
                      ),
                    if (negativeText?.isNotEmpty == true)
                      const SizedBox(width: 8),
                    Expanded(
                      child: AppFilledButtonWidget(
                        positiveText,
                        fillColor: positiveButtonColor,
                        onPressed: onPositiveFunc != null
                            ? () => onPositiveFunc?.call()
                            : () => Navigator.pop(context),
                      ),
                    )
                  ],
                )
          ],
        ),
      ),
    );
  }
}
