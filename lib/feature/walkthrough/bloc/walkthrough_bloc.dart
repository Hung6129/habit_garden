import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:habit_garden/core/data/local/app_pref_key.dart';
import 'package:habit_garden/core/data/local/app_shared_pref.dart';
import 'package:habit_garden/core/services/injection_service.dart';
import 'package:habit_garden/feature/home/blocs/main_bloc.dart';
import 'package:habit_garden/share/widgets/loading/app_loading_indicator.dart';
import 'package:habit_garden/share/widgets/loading/app_loading_widget.dart';
import 'package:habit_garden/feature/authenticate/presentation/bloc/authenticate_bloc.dart';

part 'walkthrough_event.dart';
part 'walkthrough_state.dart';
part '../pages/walkthrough_page.dart';

class WalkthroughBloc extends Bloc<WalkthroughEvent, WalkthroughState> {
  WalkthroughBloc() : super(WalkthroughState()) {
    on<WalkthroughStarted>(_onWalkthroughStarted);
  }

  void _onWalkthroughStarted(
    WalkthroughStarted event,
    Emitter<WalkthroughState> emit,
  ) async {
    emit(state.copyWith(status: WalkThroughStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    var status = await iS<AppSharedPref>()
            .getValue(AppPrefKey.isSavePassword, 'false') ==
        'true';

    if (status) {
      emit(state.copyWith(status: WalkThroughStatus.loggedIn));
    } else {
      emit(state.copyWith(status: WalkThroughStatus.completed));
    }
  }
}
