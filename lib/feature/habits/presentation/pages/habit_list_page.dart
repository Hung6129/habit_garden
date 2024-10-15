part of '../blocs/habit_bloc.dart';

class HabitListPage extends StatefulWidget {
  const HabitListPage({super.key});

  @override
  State<HabitListPage> createState() => _HabitListPageState();
}

class _HabitListPageState extends State<HabitListPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => iS<HabitBloc>()
        ..add(
          GetAllHabitByUserIdEvent(),
        ),
      child: _buildBody(),
    );
  }

  Stack _buildBody() {
    return Stack(
      children: [
        BlocConsumer<HabitBloc, HabitState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetAllHabitByUserIdState) {
              if (state.status == GetAllHabitByUserIdEnum.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.status == GetAllHabitByUserIdEnum.loaded) {
                return RefreshIndicator(
                  onRefresh: () async {
                    iS<HabitBloc>().add(RefreshHabitListEvent());
                  },
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.habits.length,
                    itemBuilder: (context, index) {
                      final habit = state.habits[index];
                      return HabitCardWidget(
                        habit: habit,
                        onDetailAction: () {},
                        onRemoveAction: () {},
                      );
                    },
                  ),
                );
              }
              if (state.status == GetAllHabitByUserIdEnum.error) {
                return Center(child: Text(state.errorMesssage));
              }
            }
            return Container();
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: AppFloatingButtonWidget(
            icon: Icons.add,
            onPressed: () => _showFormCreateNewHabit(context),
          ),
        ),
      ],
    );
  }

  _showFormCreateNewHabit(
    BuildContext context,
  ) {
    return DialogUtil.onDialogCreateHabit(
      context,
      title: 'Create New Habit',
      onNegativeFunc: () {
        Navigator.pop(context);
      },
      onPositiveFunc: () {
        if (_formKey.currentState?.saveAndValidate() == true) {
          debugPrint(_formKey.currentState?.value.toString());
          // final habit = HabitModel(
          //   name: _formKey.currentState?.fields['name']?.value,
          //   description: _formKey.currentState?.fields['description']?.value,
          //   duration: _formKey.currentState?.fields['duration']?.value,
          // );
          // iS<HabitBloc>().add(CreateHabitEvent(habit));
          // Navigator.pop(context);
        }
      },
      positiveText: 'Create',
      negativeText: 'Cancel',
      subWidget: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            FormUtils.renderInputField(
              context,
              key: 'name',
              label: 'Name',
              validator: (value) => ValidatorUtil.requireValidator(value),
              require: true,
              hintText: 'Enter habit name',
            ),
            SizedBox(
              height: AppUIConstants.majorScalePadding(8),
            ),
            FormUtils.renderInputField(
              context,
              key: 'description',
              validator: (value) => ValidatorUtil.requireValidator(value),
              require: true,
              label: 'Description',
              hintText: 'Enter habit description',
            ),
            SizedBox(
              height: AppUIConstants.majorScalePadding(8),
            ),
            FormBuilderField<String?>(
              name: 'duration',
              builder: (field) {
                return InkWell(
                  onTap: () async {
                    var resultingDuration = await showDurationPicker(
                      context: context,
                      initialTime: const Duration(minutes: 30),
                    );
                    field.didChange(resultingDuration.toString());
                    _formKey.currentState?.fields['duration']
                        ?.didChange(resultingDuration!.inMinutes.toString());
                  },
                  child: AppTextFieldWidget(
                    isRequired: true,
                    validator: (value) => ValidatorUtil.requireValidator(value),
                    label: 'Duration',
                    hintText: 'Enter habit duration',
                    initValue: field.value,
                    isDisabled: true,
                    onChanged: (model) => {},
                  ),
                );
              },
            ),
            SizedBox(
              height: AppUIConstants.majorScalePadding(8),
            ),
          ],
        ),
      ),
    );
  }
}
