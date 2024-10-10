part of 'walkthrough_bloc.dart';

enum WalkThroughStatus { initial, loading, completed, loggedIn }

class WalkthroughState extends Equatable {
  WalkThroughStatus status;
  WalkthroughState({
    this.status = WalkThroughStatus.initial,
  });

  WalkthroughState copyWith({
    WalkThroughStatus? status,
  }) {
    return WalkthroughState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}

// sealed class WalkthroughState {
//   const WalkthroughState();
// }

// final class WalkthroughInitial extends WalkthroughState {
//   const WalkthroughInitial();
// }

// final class WalkthroughLoading extends WalkthroughState {
//   const WalkthroughLoading();
// }

// final class WalkthroughCompleted extends WalkthroughState {
//   const WalkthroughCompleted();
// }
