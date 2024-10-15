import 'package:flutter/material.dart';

import 'package:habit_garden/share/themes/app_theme.dart';

class AppCheckBoxWidget extends StatelessWidget {
  const AppCheckBoxWidget(
      {super.key,
      required this.value,
      this.isReadOnly = false,
      this.onChanged});

  final bool value;
  final bool isReadOnly;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18,
      height: 18,
      child: Checkbox(
        value: value,
        onChanged: (value) => onChanged?.call(value ?? false),
        fillColor: isReadOnly
            ? WidgetStateProperty.all(
                Theme.of(context).appColor.neutralColor[40],
              )
            : null,
      ),
    );
  }
}
