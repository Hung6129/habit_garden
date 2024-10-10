import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class MainSignOutEvent extends MainEvent {
  const MainSignOutEvent();
}
