import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:habit_garden/share/themes/app_theme.dart';
import 'buttons/app_icon_button_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    required this.text,
    this.textWidget,
    this.textStyle,
    this.leading,
    this.leadingWidget,
    this.actions,
    this.goBack,
    this.goBackEnabled = true,
    this.bottomWidget = const SizedBox(),
    this.bottomHeight = 0,
    this.backgroundColor,
    this.enableWarningInternetConnect = true,
    this.bottomRightRadius = 20,
    super.key,
  });

  final String text;
  final Widget? textWidget;
  final TextStyle? textStyle;
  final IconData? leading;
  final List<Widget>? actions;
  final bool goBackEnabled;
  final Widget? leadingWidget;
  final Function? goBack;
  final Widget bottomWidget;
  final double bottomHeight;
  final Color? backgroundColor;
  final bool enableWarningInternetConnect;
  final int bottomRightRadius;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: goBackEnabled
          ? AppIconButtonWidget(
              icon: leading ?? Icons.arrow_back,
              iconColor: Theme.of(context).colorScheme.onPrimary,
              onPressed: goBack != null
                  ? () => goBack?.call()
                  : () => Navigator.pop(context),
            )
          : (leadingWidget ?? Container()),
      title: textWidget ??
          AutoSizeText(
            text,
            maxLines: 1,
            style: textStyle ??
                Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
      centerTitle: true,
      actions: actions ?? [Container()],
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      flexibleSpace: Container(
        color: backgroundColor ?? Theme.of(context).appColor.neutralColor[10],
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).primaryColorLight,
              Theme.of(context).primaryColor,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            // borderRadius: BorderRadius.only(
            //   bottomRight: Radius.circular(bottomRightRadius.toDouble()),
            // ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(bottomHeight + 16),
        child: Column(
          children: [
            bottomWidget,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => bottomHeight > 0
      ? Size.fromHeight(kToolbarHeight + bottomHeight + 16)
      : const Size.fromHeight(kToolbarHeight);
}
