import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:habit_garden/share/themes/app_theme.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';

import 'app_radio_group_widget.dart';
import 'app_radio_widget.dart';

class AppRadioGroupGridWidget extends StatelessWidget {
  final String label;
  final List<RadioModel> radios;
  final MainAxisAlignment mainAxisAlignment;
  final bool isRequired;
  final Function(RadioModel?) onChanged;
  final int column;
  final double offsetVertical;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  const AppRadioGroupGridWidget(
      {super.key,
      required this.label,
      required this.radios,
      required this.column,
      required this.offsetVertical,
      required this.crossAxisSpacing,
      required this.mainAxisSpacing,
      required this.onChanged,
      this.isRequired = false,
      this.mainAxisAlignment = MainAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    double height = 30 + 16;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextWidget(
              label,
              textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).appColor.neutralColor[60],
                    fontWeight: FontWeight.w500,
                  ),
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
        const SizedBox(height: 8),
        SizedBox(
          height: ((height - 4) * (radios.length / column.toDouble()).ceil())
                  .toDouble() -
              mainAxisSpacing / 2,
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            crossAxisSpacing: crossAxisSpacing,
            crossAxisCount: column,
            childAspectRatio: (MediaQuery.of(context).size.width -
                    offsetVertical * 2 -
                    crossAxisSpacing * (column - 1)) /
                column /
                height,
            children: radios.map((e) {
              return AppRadioWidget(
                title: e.label,
                currentValue: e.value,
                groupValue: e.isSelected ? e.value : '',
                onChanged: (value) => onChanged(radios
                    .firstWhereOrNull((element) => element.value == value)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
