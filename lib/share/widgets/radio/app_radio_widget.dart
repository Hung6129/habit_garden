import 'package:flutter/material.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';

class AppRadioWidget extends StatelessWidget {
  final String title;
  final String currentValue;
  final String groupValue;
  final String? description;
  final Function(String) onChanged;
  final bool bordered;
  final bool isPermittedEdit;

  const AppRadioWidget({
    super.key,
    required this.title,
    required this.currentValue,
    required this.groupValue,
    required this.onChanged,
    this.description,
    this.bordered = false,
    this.isPermittedEdit = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isPermittedEdit ? () => onChanged(currentValue) : null,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: bordered ? AppUIConstants.subHorizontalMargin : 0,
            vertical: bordered ? AppUIConstants.subVerticalMargin : 0),
        decoration: bordered
            ? BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                border: Border.all(
                    color: currentValue == groupValue
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).unselectedWidgetColor),
                borderRadius: BorderRadius.circular(4),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: AppUIConstants.radioButtonSize,
                  height: 40,
                  margin: EdgeInsets.only(
                      right: AppUIConstants.subHorizontalMargin),
                  child: Radio<String>(
                      value: currentValue,
                      groupValue: groupValue,
                      onChanged: isPermittedEdit
                          ? (value) => onChanged(value ?? '')
                          : null,
                      fillColor: WidgetStatePropertyAll(isPermittedEdit
                          ? currentValue == groupValue
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).unselectedWidgetColor
                          : Theme.of(context).hintColor),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
                ),
                AppTextWidget(
                  title,
                  textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isPermittedEdit
                          ? currentValue == groupValue
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).unselectedWidgetColor
                          : Theme.of(context).hintColor),
                ),
              ],
            ),
            if (description != null)
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: AppTextWidget(
                  description ?? '',
                  textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).unselectedWidgetColor),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
