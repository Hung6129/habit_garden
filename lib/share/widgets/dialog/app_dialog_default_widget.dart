import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/share/widgets/buttons/app_filled_button_widget.dart';
import 'package:habit_garden/share/widgets/buttons/app_outlined_button_widget.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';

class AppDialogDefaultWidget {
  const AppDialogDefaultWidget({
    required this.title,
    required this.icon,
    required this.positiveText,
    this.hasCloseIcon = true,
    this.negativeText,
    this.subText,
    this.subWidget,
    this.onNegativeFunc,
    this.onPositiveFunc,
    this.barrierDismissible = false,
    this.positiveButtonColor,
    this.customActions,
  });

  final Widget? icon;
  final bool? hasCloseIcon;
  final bool? barrierDismissible;
  final String title;
  final String? subText, negativeText;
  final Widget? subWidget;
  final String positiveText;
  final Color? positiveButtonColor;
  final Function? onNegativeFunc, onPositiveFunc;
  final Widget? customActions;

  Dialog showDialog(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.dialogBackgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            hasCloseIcon == true
                ? Container(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.close,
                          color: context.theme.iconTheme.color,
                        ),
                      ),
                    ),
                  )
                : Container(),
            if (icon != null)
              Container(
                margin: EdgeInsets.only(
                  top: hasCloseIcon == true
                      ? AppUIConstants.majorScalePadding(3)
                      : 40,
                  bottom: AppUIConstants.majorScalePadding(3),
                ),
                child: icon,
              ),
            AppTextWidget(
              title,
              textStyle: context.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            if (subText?.isNotEmpty == true)
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.5),
                child: AppTextWidget(
                  subText!,
                  textStyle: context.textTheme.bodyLarge,
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
