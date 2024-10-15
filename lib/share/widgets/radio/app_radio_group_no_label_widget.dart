import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_radio_group_widget.dart';
import 'app_radio_widget.dart';

class AppRadioGroupNoLabelWidget extends StatelessWidget {
  final List<RadioModel> radios;
  final Function(RadioModel?) onChanged;
  final bool isPermittedEdit;

  const AppRadioGroupNoLabelWidget({
    super.key,
    required this.radios,
    required this.onChanged,
    this.isPermittedEdit = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < radios.length; i++)
          Expanded(
            flex: 1,
            child: AppRadioWidget(
              title: radios[i].label,
              currentValue: radios[i].value,
              groupValue: radios[i].isSelected ? radios[i].value : '',
              onChanged: (value) => onChanged(
                  radios.firstWhereOrNull((element) => element.value == value)),
              isPermittedEdit: isPermittedEdit,
            ),
          ),
      ],
    );
  }
}
