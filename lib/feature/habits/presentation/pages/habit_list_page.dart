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
                    iS<HabitBloc>().add(GetAllHabitByUserIdEvent());
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
    return showBottomSheet(
      backgroundColor: Colors.blue,
      context: context,
      builder: (context) {
        return FormBuilder(
          key: _formKey,
          child: SizedBox(
            height: 400,
            child: Column(
              children: <Widget>[
                AppTextWidget('Create New Habit',
                    textStyle: Theme.of(context).textTheme.headlineMedium),
                FormUtils.renderInputField(
                  context,
                  key: 'name',
                  label: 'Habit Name',
                  hintText: 'Enter habit name',
                ),
                GestureDetector(
                  onTap: () async {
                    var resultingDuration = await showDurationPicker(
                      context: context,
                      initialTime: Duration(minutes: 30),
                    );
                    print(resultingDuration);
                  },
                  child: FormUtils.renderInputField(
                    context,
                    key: 'duration',
                    label: 'Duration',
                    isViewTextOnly: true,
                    hintText: 'Select duration',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
