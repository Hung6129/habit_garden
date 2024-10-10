import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:habit_garden/core/services/injection_service.dart';
import 'package:habit_garden/share/widgets/loading/app_loading_indicator.dart';
import 'package:habit_garden/share/themes/app_theme.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'core/networks/network_service.dart';
import 'core/services/state_observer.dart';
import 'feature/walkthrough/bloc/walkthrough_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InjectionService.registerServices();
  Get.put<NetworkService>(NetworkServiceImpl());
  Bloc.observer = StateBlocObserver();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Đặt màn hình ở chế độ dọc mặc định trên mọi thiết bị
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: AppFullScreenLoadingIndicator.init(
        builder: ((context, child) => MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            )),
      ),
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi', 'vi_VN'),
      ],
      home: const WalkThroughPage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      super.createHttpClient(context)
        ..badCertificateCallback = (
          X509Certificate cert,
          String host,
          int port,
        ) =>
            true;
}
