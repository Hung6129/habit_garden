import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:habit_garden/share/themes/app_theme.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';
import 'app_radio_widget.dart';

class RadioModel {
  final String label;
  final String value;
  bool isSelected;

  RadioModel copyWith({
    String? label,
    String? value,
    bool? isSelected,
  }) {
    return RadioModel(
      label: label ?? this.label,
      value: value ?? this.value,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  RadioModel(
      {required this.label, required this.value, this.isSelected = false});
}

class AppRadioGroupWidget extends StatelessWidget {
  final String label;
  final List<RadioModel> radios;
  final MainAxisAlignment mainAxisAlignment;
  final bool isRequired;
  final Function(RadioModel?) onChanged;
  final bool isPermittedEdit;

  const AppRadioGroupWidget({
    super.key,
    required this.label,
    required this.radios,
    required this.onChanged,
    this.isRequired = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.isPermittedEdit = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextWidget(
              label,
              textStyle: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.get().neutralColor[60]),
            ),
            if (isRequired) const SizedBox(width: 2),
            if (isRequired)
              AppTextWidget(
                '*',
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Theme.of(context).appColor.errorColor),
              )
          ],
        ),
        Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            for (int i = 0; i < radios.length; i++)
              Expanded(
                flex: i < radios.length - 1 ? 3 : 2,
                child: AppRadioWidget(
                  title: radios[i].label,
                  currentValue: radios[i].value,
                  groupValue: radios[i].isSelected ? radios[i].value : '',
                  onChanged: (value) => onChanged(radios
                      .firstWhereOrNull((element) => element.value == value)),
                  isPermittedEdit: isPermittedEdit,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
