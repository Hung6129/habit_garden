part of '../bloc/walkthrough_bloc.dart';

class WalkThroughPage extends StatelessWidget {
  const WalkThroughPage({super.key});

  @override
  Widget build(BuildContext context) {
    // set config for loading indicator
    AppFullScreenLoadingIndicator.configure(context);
    return BlocProvider(
      create: (context) => iS<WalkthroughBloc>()..add(WalkthroughStarted()),
      child: BlocConsumer<WalkthroughBloc, WalkthroughState>(
        listener: (context, state) async {
          if (state.status == WalkThroughStatus.completed) {
            SignInPage.openFromWalkThrough(context);
          }
          if (state.status == WalkThroughStatus.loggedIn) {
            MainPage.openFromAuth(context);
          }
        },
        builder: (context, state) => _buildBody(),
      ),
    );
  }

  Stack _buildBody() {
    return const Stack(
      children: [
        Positioned(
          bottom: kBottomNavigationBarHeight,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppLoadingWidget(),
            ],
          ),
        )
      ],
    );
  }
}
