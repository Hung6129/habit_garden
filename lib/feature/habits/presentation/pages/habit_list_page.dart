part of '../blocs/habit_bloc.dart';

class HabitListPage extends StatefulWidget {
  const HabitListPage({super.key});

  @override
  State<HabitListPage> createState() => _HabitListPageState();
}

class _HabitListPageState extends State<HabitListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => iS<HabitBloc>()
        ..add(
          GetAllHabitByUserIdEvent(),
        ),
      child: Stack(
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
                  return ListView.builder(
                    itemCount: state.habits.length,
                    itemBuilder: (context, index) {
                      final habit = state.habits[index];
                      return HabitCardWidget(
                        habit: habit,
                        onDetailAction: () {},
                        onRemoveAction: () {},
                      );
                    },
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
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
