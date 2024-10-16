part of '../blocs/main_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static openFromAuth(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
    );
  }

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> listScreens = [
    // Add your screens here
    const HabitListPage(),
    const Center(
      child: Text('Notification Page 2'),
    ),
  ];

  List<Widget> listBottomNavItems = const [
    NavigationDestination(
      selectedIcon: Icon(Icons.imagesearch_roller_rounded),
      icon: Icon(Icons.imagesearch_roller_rounded),
      label: 'Habits',
    ),
    NavigationDestination(
      icon: Icon(Icons.notifications_sharp),
      selectedIcon: Icon(Icons.notifications),
      label: 'Notifications',
    ),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => iS<MainBloc>(),
      child: BlocConsumer<MainBloc, MainState>(
        listener: (context, state) async {
          if (state.status == MainStatus.signOut) {
            SignInPage.openFromWalkThrough(context);
          }
        },
        builder: (context, state) => AppMainWidget(
          body: listScreens[currentIndex],
          appBarWidget: _buildAppBar(context),
          bottomNavigationBar: _buildBottomNav(),
        ),
      ),
    );
  }

  NavigationBar _buildBottomNav() {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      indicatorColor: Colors.amber,
      selectedIndex: currentIndex,
      destinations: listBottomNavItems,
    );
  }

  AppBarWidget _buildAppBar(BuildContext context) {
    return AppBarWidget(
      text: 'Habit Garden',
      goBackEnabled: false,
      leadingWidget: AppIconButtonWidget(
        iconColor: Colors.white,
        size: 30,
        icon: Icons.person_4,
        onPressed: () {},
      ),
      actions: [
        AppIconButtonWidget(
          iconColor: Colors.white,
          icon: Icons.logout,
          size: 30,
          onPressed: () => _showDialogConfirmSignOut(context),
        ),
      ],
    );
  }

  _showDialogConfirmSignOut(BuildContext context) {
    DialogUtil.onDialogConfirm(
      context,
      title: 'Sign Out',
      subText: 'Are you sure you want to sign out?',
      positiveText: 'Yes',
      negativeText: 'No',
      onPositiveFunc: () {
        Navigator.of(context).pop();
        context.read<MainBloc>().add(const MainSignOutEvent());
      },
      onNegativeFunc: () {
        Navigator.of(context).pop();
      },
    );
  }
}
