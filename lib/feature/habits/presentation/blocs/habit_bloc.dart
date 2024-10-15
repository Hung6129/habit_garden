import 'package:duration_picker/duration_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/core/data/local/app_pref_key.dart';
import 'package:habit_garden/core/data/local/app_shared_pref.dart';
import 'package:habit_garden/core/networks/nets/app_result.dart';
import 'package:habit_garden/core/utils/dialog_util.dart';
import 'package:habit_garden/core/utils/form_utils.dart';
import 'package:habit_garden/core/utils/validator_util.dart';
import 'package:habit_garden/feature/habits/domain/entities/habit_entity.dart';
import 'package:habit_garden/feature/habits/domain/usecase/habit_usecase.dart';
import 'package:habit_garden/feature/habits/presentation/blocs/habit_event.dart';
import 'package:habit_garden/feature/habits/presentation/blocs/habit_state.dart';
import 'package:habit_garden/feature/habits/presentation/pages/habit_card_widget.dart';
import 'package:habit_garden/share/widgets/buttons/app_floating_button_widget.dart';
import 'package:habit_garden/share/widgets/texts/app_text_field_widget.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:habit_garden/core/services/injection_service.dart';

part '../pages/habit_list_page.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final HabitUsecase habitUsecase;

  final _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  HabitBloc(this.habitUsecase) : super(const HabitInitial()) {
    on<GetAllHabitByUserIdEvent>(_onGetAllHabitByUserId);

    on<RefreshHabitListEvent>(_onRefreshHabitListEvent);
  }

  Future<void> _onRefreshHabitListEvent(
    RefreshHabitListEvent event,
    Emitter<HabitState> emit,
  ) async {
    emit(GetAllHabitByUserIdState(status: GetAllHabitByUserIdEnum.loading));
    final res = await habitUsecase.getAllHabitsByUserId(
      userId: await iS<AppSharedPref>().getValue(AppPrefKey.userId, ''),
    );
    if (res is AppResultSuccess<List<HabitEntity>>) {
      // _logger.i('_onGetAllHabitByUserId: ${res.netData}');
      return emit(GetAllHabitByUserIdState(
        habits: res.netData!,
        status: GetAllHabitByUserIdEnum.loaded,
      ));
    }
  }

  Future<void> _onGetAllHabitByUserId(
    GetAllHabitByUserIdEvent event,
    Emitter<HabitState> emit,
  ) async {
    emit(
      GetAllHabitByUserIdState(
        status: GetAllHabitByUserIdEnum.loading,
        habits: [],
      ),
    );
    final res = await habitUsecase.getAllHabitsByUserId(
      userId: await iS<AppSharedPref>().getValue(AppPrefKey.userId, ''),
    );
    if (res is AppResultSuccess<List<HabitEntity>>) {
      // _logger.i('_onGetAllHabitByUserId: ${res.netData}');
      return emit(GetAllHabitByUserIdState(
        habits: res.netData!,
        status: GetAllHabitByUserIdEnum.loaded,
      ));
    }
    if (res is AppResultFailure) {
      _logger.e(
          '_onGetAllHabitByUserId: ${(res as AppResultFailure).exception?.message}');
      return emit(
        GetAllHabitByUserIdState(
          status: GetAllHabitByUserIdEnum.error,
          errorMesssage: (res as AppResultFailure).exception?.message ?? '',
        ),
      );
    }
  }
}
