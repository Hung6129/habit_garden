import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_garden/core/translations/strings.dart';
import 'package:habit_garden/share/widgets/buttons/app_filled_button_widget.dart';
import 'package:habit_garden/share/widgets/buttons/app_outlined_button_widget.dart';
import 'package:habit_garden/share/widgets/dialog/app_dialog_default_widget.dart';
import 'package:habit_garden/share/themes/app_theme.dart';

class DialogUtil {
  DialogUtil._();

  static Future<void> onDialogWarning(
    BuildContext context, {
    required String title,
    bool hasCloseIcon = false,
    String? subText,
    Widget? subWidget,
    String? positiveText,
    String? negativeText,
    Function? onPositiveFunc,
    Function? onNegativeFunc,
    bool barrierDismissible = false,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AppDialogDefaultWidget(
          icon: SvgPicture.asset('assets/vectors/ic_waring_on_dialog.svg'),
          title: title,
          subText: subText,
          subWidget: subWidget,
          hasCloseIcon: hasCloseIcon,
          positiveText: positiveText ?? Strings.close,
          negativeText: negativeText,
          onPositiveFunc: onPositiveFunc,
          onNegativeFunc: onNegativeFunc,
          barrierDismissible: barrierDismissible,
        ).showDialog(context);
      },
    );
  }

  static Future<void> onDialogError(
    BuildContext context, {
    required String title,
    bool hasCloseIcon = false,
    String? subText,
    Widget? subWidget,
    String? positiveText,
    String? negativeText,
    Function? onPositiveFunc,
    Function? onNegativeFunc,
    bool barrierDismissible = false,
  }) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AppDialogDefaultWidget(
            icon: SvgPicture.asset('assets/vectors/ic_error_on_dialog.svg'),
            title: title,
            subText: subText,
            subWidget: subWidget,
            hasCloseIcon: hasCloseIcon,
            positiveText: positiveText ?? Strings.close,
            negativeText: negativeText,
            onPositiveFunc: onPositiveFunc,
            onNegativeFunc: onNegativeFunc,
            barrierDismissible: barrierDismissible,
          ).showDialog(context);
        });
  }

  static Future<void> onDialogConfirmWithoutIcon(
    BuildContext context, {
    required String title,
    String? subText,
    bool hasCloseIcon = false,
    String? positiveText,
    String? negativeText,
    Function? onPositiveFunc,
    Function? onNegativeFunc,
    bool barrierDismissible = false,
  }) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AppDialogDefaultWidget(
            icon: null,
            title: title,
            subText: subText,
            hasCloseIcon: hasCloseIcon,
            positiveText: positiveText ?? Strings.close,
            negativeText: negativeText,
            onPositiveFunc: onPositiveFunc,
            onNegativeFunc: onNegativeFunc,
            barrierDismissible: barrierDismissible,
          ).showDialog(context);
        });
  }

  static void onDialogCancelWithoutIcon(
    BuildContext context, {
    required String title,
    String? subText,
    bool hasCloseIcon = false,
    String? positiveText,
    String? negativeText,
    Function? onPositiveFunc,
    Function? onNegativeFunc,
    bool barrierDismissible = false,
  }) {
    AppDialogDefaultWidget(
      icon: null,
      title: title,
      subText: subText,
      hasCloseIcon: hasCloseIcon,
      positiveText: positiveText ?? Strings.close,
      negativeText: negativeText,
      onPositiveFunc: onPositiveFunc,
      positiveButtonColor: AppColors.get().errorColor,
      onNegativeFunc: onNegativeFunc,
      barrierDismissible: barrierDismissible,
    ).showDialog(context);
  }

  static Future<void> onDialogSuccess(
    BuildContext context, {
    required String title,
    String? subText,
    Widget? subWidget,
    bool hasCloseIcon = false,
    String? positiveText,
    String? negativeText,
    Function? onPositiveFunc,
    Function? onNegativeFunc,
    bool barrierDismissible = false,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AppDialogDefaultWidget(
            icon: SvgPicture.asset('assets/vectors/ic_success_on_dialog.svg'),
            title: title,
            subText: subText,
            subWidget: subWidget,
            hasCloseIcon: hasCloseIcon,
            positiveText: positiveText ?? Strings.close,
            negativeText: negativeText,
            onPositiveFunc: onPositiveFunc,
            onNegativeFunc: onNegativeFunc,
            barrierDismissible: barrierDismissible,
          ).showDialog(context);
        });
  }

  static Future<void> onDialogConfirm(
    BuildContext context, {
    required String title,
    String? subText,
    Widget? subWidget,
    bool hasCloseIcon = false,
    bool hasIcon = true,
    Function? onPositiveFunc,
    Function? onNegativeFunc,
    String? positiveText,
    String? negativeText,
    Color? positiveButtonColor,
    bool barrierDismissible = false,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AppDialogDefaultWidget(
            icon: hasIcon
                ? SvgPicture.asset('assets/vectors/ic_waring_on_dialog.svg')
                : null,
            title: title,
            hasCloseIcon: hasCloseIcon,
            subText: subText,
            subWidget: subWidget,
            negativeText: negativeText ?? Strings.close,
            positiveText: positiveText ?? Strings.confirm,
            onPositiveFunc: onPositiveFunc,
            onNegativeFunc: onNegativeFunc,
            positiveButtonColor: positiveButtonColor,
            barrierDismissible: barrierDismissible,
          ).showDialog(context);
        });
  }

  static void onDialogConfirmDelete(
    BuildContext context, {
    required String title,
    String? subText,
    Widget? subWidget,
    bool hasCloseIcon = false,
    bool hasIcon = true,
    Function? onPositiveFunc,
    Function? onNegativeFunc,
    String? positiveText,
    String? negativeText,
    Color? positiveButtonColor,
    bool barrierDismissible = false,
  }) {
    AppDialogDefaultWidget(
      icon: hasIcon
          ? SvgPicture.asset('assets/vectors/ic_delete_on_dialog.svg')
          : null,
      title: title,
      hasCloseIcon: hasCloseIcon,
      subText: subText,
      subWidget: subWidget,
      negativeText: negativeText ?? Strings.close,
      positiveText: positiveText ?? Strings.confirm,
      onPositiveFunc: onPositiveFunc,
      onNegativeFunc: onNegativeFunc,
      positiveButtonColor: positiveButtonColor,
      barrierDismissible: barrierDismissible,
    ).showDialog(context);
  }

  static Widget dialogFooter(
    BuildContext context, {
    required String positiveText,
    required String negativeText,
    Function? onPositiveFunc,
    Function? onNegativeFunc,
    bool isPositiveEnabled = true,
  }) {
    return Row(
      children: [
        Expanded(
          child: AppOutlinedButtonWidget(
            negativeText,
            onPressed: () => onNegativeFunc?.call(),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: AppFilledButtonWidget(
            positiveText,
            isEnable: isPositiveEnabled,
            onPressed: () => onPositiveFunc?.call(),
          ),
        ),
      ],
    );
  }

  //todo rename
  static void onDialogDetailFailure(
    BuildContext context, {
    Function? onPositiveFunc,
    bool isDetailRequest = true,
  }) {
    DialogUtil.onDialogError(
      context,
      title: Strings.getDataFailure,
      onPositiveFunc: onPositiveFunc != null
          ? onPositiveFunc.call
          : isDetailRequest
              ? () => Navigator.pop(context)
              : () => Navigator.pop(context),
    );
  }

  static void onDialogDownloadFileFailure(
    BuildContext context, {
    Function? onPositiveFunc,
  }) {
    DialogUtil.onDialogError(
      context,
      title: Strings.downloadFileFailure,
      onPositiveFunc: onPositiveFunc != null
          ? onPositiveFunc.call
          : () => Navigator.pop(context),
    );
  }
}
