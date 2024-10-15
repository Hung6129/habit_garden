import 'package:flutter/material.dart';
import 'package:habit_garden/core/utils/card_utils.dart';
import 'package:habit_garden/feature/habits/domain/entities/habit_entity.dart';
import 'package:habit_garden/share/widgets/card/app_card_layout.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';

class HabitCardWidget extends StatelessWidget {
  const HabitCardWidget({
    super.key,
    required this.habit,
    this.onDetailAction,
    this.onRemoveAction,
  });

  final HabitEntity habit;

  final Function? onDetailAction;
  final Function? onRemoveAction;

  @override
  Widget build(BuildContext context) {
    return AppCardLayoutWidget(
      bgColor: habit.priority == "HIGH"
          ? const Color.fromARGB(255, 231, 187, 183)
          : habit.priority == "MEDIUM"
              ? const Color.fromARGB(255, 223, 191, 145)
              : const Color.fromARGB(255, 139, 213, 141),
      actions: [
        CardUtils.buildEdit(context, onDetailAction),
        CardUtils.buildDelete(context, onRemoveAction),
      ],
      header: AppTextWidget(
        habit.name,
        textStyle: Theme.of(context).textTheme.titleMedium,
      ),
      content: AppTextWidget(
        habit.description,
        textStyle: Theme.of(context).textTheme.bodyMedium,
      ),
      subContent: AppTextWidget(
        habit.priority,
        textStyle: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
