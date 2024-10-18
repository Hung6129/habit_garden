import 'package:flutter/material.dart';
import 'package:habit_garden/core/data/local/app_pref_key.dart';
import 'package:habit_garden/core/data/local/app_shared_pref.dart';
import 'package:habit_garden/core/services/injection_service.dart';
import 'package:habit_garden/feature/authenticate/presentation/bloc/authenticate_bloc.dart';
import 'package:habit_garden/main.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';
import 'package:logger/logger.dart';

abstract class AppServices {
  void forceLogout();
}

class AppServicesImpl extends AppServices {
  final Logger _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  @override
  void forceLogout() async {
    _logger.e('Force Logout');
    await iS<AppSharedPref>().deleteValue(AppPrefKey.userName);
    await iS<AppSharedPref>().deleteValue(AppPrefKey.email);
    await iS<AppSharedPref>().deleteValue(AppPrefKey.userId);
    await iS<AppSharedPref>().deleteValue(AppPrefKey.token);
    await iS<AppSharedPref>().deleteValue(AppPrefKey.refreshToken);
    await iS<AppSharedPref>().deleteValue(AppPrefKey.isSavePassword);
    snackbarKey.currentState!.showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
        content: AppTextWidget(
          'Your session has expired. Please login again.',
          textStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
    navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const SignInPage(),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
