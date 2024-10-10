import 'package:flutter/material.dart';

import 'app_checkbox_widget.dart';

class AppTextCheckBoxWidget extends StatelessWidget {
  const AppTextCheckBoxWidget(
      {super.key,
      required this.value,
      required this.child,
      this.onChanged,
      this.isReadOnly = false,
      this.crossAlignment});

  final Widget child;
  final bool value;
  final Function(bool)? onChanged;
  final bool isReadOnly;
  final CrossAxisAlignment? crossAlignment;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isReadOnly,
      child: Row(
        crossAxisAlignment: crossAlignment ?? CrossAxisAlignment.start,
        children: [
          AppCheckBoxWidget(
            value: value,
            isReadOnly: isReadOnly,
            onChanged: onChanged,
          ),
          const SizedBox(width: 12),
          Expanded(child: child),
        ],
      ),
    );
  }
}
