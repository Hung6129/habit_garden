import 'package:flutter/material.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/share/widgets/app_icon_widget.dart';

class AppFloatingButtonWidget extends StatelessWidget {
  const AppFloatingButtonWidget({
    super.key,
    required this.icon,
    this.onPressed,
  });

  final IconData icon;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => onPressed?.call(),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppUIConstants.defaultPadding),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColorLight,
              Theme.of(context).primaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.clamp,
          ),
        ),
        child: AppIconWidget(
          icon,
          bgColor: Colors.transparent,
          iconColor: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
