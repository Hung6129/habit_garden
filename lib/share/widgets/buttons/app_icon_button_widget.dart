import 'package:flutter/material.dart';

class AppIconButtonWidget extends StatelessWidget {
  const AppIconButtonWidget(
      {super.key,
      required this.icon,
      required this.onPressed,
      this.size,
      this.iconColor,
      this.isLeading = false});

  final IconData icon;
  final double? size;
  final Color? iconColor;
  final bool isLeading;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return isLeading
        ? SizedBox(
            width: 56,
            height: 56,
            child: IconButton(
              iconSize: size ?? 24,
              color: iconColor ?? Theme.of(context).colorScheme.background,
              icon: Icon(icon),
              onPressed: () => onPressed.call(),
            ),
          )
        : IconButton(
            color: iconColor ?? Theme.of(context).iconTheme.color,
            iconSize: size ?? 24,
            icon: Icon(
              icon,
            ),
            onPressed: () => onPressed.call(),
          );
  }
}
