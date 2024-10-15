import 'dart:io';

import 'package:flutter/material.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';

class WidgetUtils {
  static Widget footerSpace() {
    if (Platform.isAndroid) {
      return const SizedBox(
        height: 32,
      );
    } else {
      return SizedBox(height: AppUIConstants.majorScalePadding(4));
    }
  }

  static Widget renderSection(
      BuildContext context, String sectionTitle, List<Widget> listField) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: AppTextWidget(
            sectionTitle,
            textStyle: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Column(
          children: [
            ...listField,
          ],
        ),
      ],
    );
  }
}
