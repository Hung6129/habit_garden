enum MainStatus { initial, signOut }

class MainState {
  final MainStatus status;

  MainState({this.status = MainStatus.initial});

  MainState copyWith({MainStatus? status}) {
    return MainState(status: status ?? this.status);
  }
}
