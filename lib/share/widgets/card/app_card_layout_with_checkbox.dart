import 'package:flutter/material.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/share/widgets/card/app_slidable_widget.dart';

class AppCardLayoutWidgetWithCheckBox extends StatelessWidget {
  const AppCardLayoutWidgetWithCheckBox({
    super.key,
    this.onDetailAction,
    required this.actions,
    required this.header,
    this.subHeader,
    this.content,
    this.subContent,
    this.hasPadding = true,
    this.hasBorder = true,
    this.onSelection,
    this.isSelected = false,
  });

  final Function? onDetailAction;
  final List<Widget> actions;
  final Widget header;
  final Widget? subHeader;
  final Widget? content;
  final Widget? subContent;
  final bool hasPadding;
  final bool hasBorder;
  final bool isSelected;
  final Function(bool)? onSelection;

  @override
  Widget build(BuildContext context) {
    return AppSlidableWidget(
      actions: actions,
      isDisabled: actions.isEmpty,
      child: InkWell(
        onTap: () => onSelection?.call(!isSelected),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16).copyWith(right: 16, top: 20),
              child: SizedBox(
                width: 18,
                height: 18,
                child: Checkbox(
                  value: isSelected,
                  onChanged: (value) {},
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => onDetailAction?.call(),
                child: Padding(
                  padding: hasPadding
                      ? EdgeInsets.all(AppUIConstants.mainHorizontalMargin)
                          .copyWith(left: 0)
                      : EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      header,
                      if (subHeader != null)
                        Container(
                          margin:
                              EdgeInsets.only(top: AppUIConstants.minPadding),
                          child: subHeader,
                        ),
                      if (content != null)
                        Container(
                          margin:
                              EdgeInsets.only(top: AppUIConstants.minPadding),
                          child: content,
                        ),
                      if (subContent != null)
                        Container(
                          margin:
                              EdgeInsets.only(top: AppUIConstants.minPadding),
                          child: subContent!,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if (hasBorder)
          Divider(
            endIndent: AppUIConstants.mainHorizontalMargin,
            indent: AppUIConstants.mainHorizontalMargin,
          ),
      ],
    );
  }
}
