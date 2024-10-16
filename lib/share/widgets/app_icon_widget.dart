import 'package:flutter/material.dart';

class AppIconWidget extends StatelessWidget {
  const AppIconWidget(
    this.icon, {
    super.key,
    this.bgSize = 24,
    this.iconSize = 16,
    this.bgColor,
    this.iconColor,
    this.iconAlignment = Alignment.center,
  });

  final IconData icon;
  final double? iconSize;
  final Color? bgColor;
  final Color? iconColor;
  final double? bgSize;
  final Alignment iconAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: bgSize,
      height: bgSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor ?? Theme.of(context).scaffoldBackgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon,
          size: iconSize,
          color: iconColor ?? Theme.of(context).iconTheme.color),
    );
  }
}
