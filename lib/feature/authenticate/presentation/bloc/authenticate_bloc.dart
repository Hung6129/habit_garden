import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/core/data/local/app_pref_key.dart';
import 'package:habit_garden/core/data/local/app_shared_pref.dart';
import 'package:habit_garden/core/data/params/authenticate_param.dart';
import 'package:habit_garden/core/networks/nets/app_result.dart';
import 'package:habit_garden/core/services/injection_service.dart';
import 'package:habit_garden/core/utils/dialog_util.dart';
import 'package:habit_garden/core/utils/form_utils.dart';
import 'package:habit_garden/core/utils/validator_util.dart';
import 'package:habit_garden/feature/home/blocs/main_bloc.dart';

import 'package:habit_garden/share/widgets/app_bar_widget.dart';
import 'package:habit_garden/share/widgets/app_main_widget.dart';
import 'package:habit_garden/share/widgets/buttons/app_filled_button_widget.dart';
import 'package:habit_garden/share/widgets/buttons/app_outlined_button_widget.dart';
import 'package:habit_garden/share/widgets/checkbox/app_text_checkbox_widget.dart';
import 'package:habit_garden/share/widgets/loading/app_loading_indicator.dart';
import 'package:habit_garden/feature/authenticate/domain/entities/user_entity.dart';
import 'package:habit_garden/feature/authenticate/domain/usecases/authenticate_usecase.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';
import 'package:logger/logger.dart';

part 'authenticate_event.dart';
part 'authenticate_state.dart';
part '../pages/signin_page.dart';
part '../pages/signup_page.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  final AuthenticateUsecase authenticateUsecase;
  AuthenticateBloc(this.authenticateUsecase)
      : super(
          const AuthenticateState(),
        ) {
    on<SignInWithEmailAndPassword>(_onSignInWithEmailAndPassword);

    on<SignUpWithEmailAndPassword>(_onSignUpWithEmailAndPassword);
  }
  final _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  Future<void> _onSignInWithEmailAndPassword(
    SignInWithEmailAndPassword event,
    Emitter<AuthenticateState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticateStatus.loading));
    final res = await authenticateUsecase.signInWithEmailAndPassword(
        signInParam: event.signInParam);
    if (res is AppResultSuccess<UserEntity>) {
      if (event.isRememberMe) {
        await saveUserToLocal(res.netData!, event.isRememberMe);
      }
      return emit(
        AuthenticateState.success(res.netData!, event.isRememberMe),
      );
    }
    if (res is AppResultFailure) {
      _logger.e(
          '_onSignInWithEmailAndPassword: ${(res as AppResultFailure).exception?.message}');
      return emit(
        AuthenticateState.failure(
          '${(res as AppResultFailure).exception?.message}',
        ),
      );
    }
  }

  saveUserToLocal(UserEntity user, bool isSavePassword) async {
    _logger.d('Save user info to local storage');
    await iS<AppSharedPref>().setValue(AppPrefKey.userName, user.username);
    await iS<AppSharedPref>().setValue(AppPrefKey.email, user.email);
    await iS<AppSharedPref>().setValue(AppPrefKey.userId, user.id);

    await iS<AppSharedPref>().setValue(AppPrefKey.token, user.token);
    await iS<AppSharedPref>()
        .setValue(AppPrefKey.refreshToken, user.refreshToken);

    await iS<AppSharedPref>()
        .setValue(AppPrefKey.isSavePassword, isSavePassword.toString());
  }

  Future<void> _onSignUpWithEmailAndPassword(
    SignUpWithEmailAndPassword event,
    Emitter<AuthenticateState> emit,
  ) async {
    emit(state.copyWith(status: AuthenticateStatus.loading));
    final res = await authenticateUsecase.signUpWithEmailAndPassword(
        signUpParam: event.signUpParam);
    if (res is AppResultSuccess<UserEntity>) {
      return emit(AuthenticateState.success(res.netData!, false));
    }
    if (res is AppResultFailure) {
      _logger.e(
          '_onSignUpWithEmailAndPassword: ${(res as AppResultFailure).exception?.message}');
      return emit(
        AuthenticateState.failure(
          '${(res as AppResultFailure).exception?.message}',
        ),
      );
    }
  }
}
