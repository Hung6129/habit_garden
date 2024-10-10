part of 'walkthrough_bloc.dart';

abstract class WalkthroughEvent extends Equatable {
  const WalkthroughEvent();

  @override
  List<Object> get props => [];
}

class WalkthroughStarted extends WalkthroughEvent {}
