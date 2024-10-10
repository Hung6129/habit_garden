import 'package:flutter/material.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/share/themes/app_theme.dart';
import 'app_slidable_widget.dart';

class AppCardLayoutWidget extends StatelessWidget {
  const AppCardLayoutWidget({
    super.key,
    this.onDetailAction,
    required this.actions,
    required this.header,
    this.subHeader,
    this.content,
    this.subContent,
    this.hasPadding = true,
    this.hasBorder = true,
  });

  final Function? onDetailAction;
  final List<Widget> actions;
  final Widget header;
  final Widget? subHeader;
  final Widget? content;
  final Widget? subContent;
  final bool hasPadding;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    return AppSlidableWidget(
      actions: actions,
      isDisabled: actions.isEmpty,
      child: onDetailAction == null
          ? _buildContent()
          : InkWell(
              onTap: () => onDetailAction?.call(),
              child: _buildContent(),
            ),
    );
  }

  Widget _buildContent() {
    return Container(
      color: AppColors.get().neutralColor[0],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: hasPadding
                ? EdgeInsets.all(AppUIConstants.majorScalePadding(4))
                : EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header,
                if (subHeader != null)
                  Container(
                    margin: EdgeInsets.only(
                        top: AppUIConstants.majorScalePadding(1)),
                    child: subHeader,
                  ),
                if (content != null)
                  Container(
                    margin: EdgeInsets.only(
                        top: AppUIConstants.majorScalePadding(1)),
                    child: content,
                  ),
                if (subContent != null)
                  Container(
                    margin: EdgeInsets.only(
                        top: AppUIConstants.majorScalePadding(1)),
                    child: subContent!,
                  ),
              ],
            ),
          ),
          if (hasBorder)
            Divider(
              endIndent: AppUIConstants.majorScalePadding(4),
              indent: AppUIConstants.majorScalePadding(4),
            ),
        ],
      ),
    );
  }
}
