import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';

class AppFullScreenLoadingIndicator {
  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return EasyLoading.init(builder: builder);
  }

  static void configure(BuildContext context) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..maskType = EasyLoadingMaskType.custom
      ..indicatorSize = 48.0
      ..radius = 10.0
      ..backgroundColor = context.theme.colorScheme.surface
      ..indicatorColor = context.theme.primaryColor
      ..progressColor = context.theme.primaryColor.withOpacity(0.6)
      ..textColor = Colors.black
      ..maskColor = Colors.black.withOpacity(0.4)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  static void show({String? message}) {
    EasyLoading.show(status: message);
  }

  static void dismiss({bool animation = true}) {
    EasyLoading.dismiss(animation: animation);
  }
}
