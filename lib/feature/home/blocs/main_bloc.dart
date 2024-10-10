import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_garden/core/data/local/app_pref_key.dart';
import 'package:habit_garden/core/data/local/app_shared_pref.dart';
import 'package:habit_garden/core/services/injection_service.dart';
import 'package:habit_garden/core/utils/dialog_util.dart';
import 'package:habit_garden/feature/authenticate/presentation/bloc/authenticate_bloc.dart';

import 'package:habit_garden/feature/home/blocs/main_event.dart';
import 'package:habit_garden/share/widgets/app_bar_widget.dart';
import 'package:habit_garden/share/widgets/app_main_widget.dart';
import 'package:habit_garden/share/widgets/buttons/app_icon_button_widget.dart';
import 'package:habit_garden/share/widgets/loading/app_loading_indicator.dart';

import 'main_state.dart';

part '../pages/main_page.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    on<MainSignOutEvent>(_onSignOut);
  }

  Future<void> _onSignOut(
    MainSignOutEvent event,
    Emitter<MainState> emit,
  ) async {
    AppFullScreenLoadingIndicator.show();
    await iS<AppSharedPref>().deleteValue(AppPrefKey.userName);
    await iS<AppSharedPref>().deleteValue(AppPrefKey.email);
    await iS<AppSharedPref>().deleteValue(AppPrefKey.userId);
    await iS<AppSharedPref>().deleteValue(AppPrefKey.token);
    await iS<AppSharedPref>().deleteValue(AppPrefKey.refreshToken);
    await iS<AppSharedPref>().deleteValue(AppPrefKey.isSavePassword);
    await Future.delayed(const Duration(milliseconds: 1500));
    AppFullScreenLoadingIndicator.dismiss();
    emit(state.copyWith(status: MainStatus.signOut));
  }
}
