import 'package:flutter/material.dart';

import '../app_icon_widget.dart';

class AppChipWidget extends StatelessWidget {
  const AppChipWidget({
    super.key,
    required this.icon,
    this.iconColor,
    this.isDot = false,
    this.onTap,
  });

  final IconData icon;
  final Color? iconColor;
  final Function()? onTap;
  final bool isDot;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 40,
            height: 32,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: AppIconWidget(
              icon,
              iconSize: 20,
              iconColor: iconColor,
            ),
          ),
          if (isDot)
            Positioned(
              top: 6,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.error,
                ),
                width: 8,
                height: 8,
              ),
            )
        ],
      ),
    );
  }
}
