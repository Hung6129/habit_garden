import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppChipSvgWidget extends StatelessWidget {
  const AppChipSvgWidget({
    Key? key,
    required this.icon,
    this.isDot = false,
    this.onTap,
    this.borderRadius,
    this.border,
  }) : super(key: key);

  final Widget icon;
  final Function()? onTap;
  final bool isDot;
  final BorderRadius? borderRadius;
  final Border? border;

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
              color: context.theme.colorScheme.surface,
              borderRadius: borderRadius ?? BorderRadius.circular(8),
              border: border,
            ),
            alignment: Alignment.center,
            child: icon,
          ),
          if (isDot)
            Positioned(
              top: 6,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.theme.colorScheme.error,
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
