import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class StateBlocObserver extends BlocObserver {
  StateBlocObserver();

  final Logger _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    _logger.i('onTransition: $transition');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _logger.i('onChange: $change');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _logger.i('onEvent: $event');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    _logger.e('onError: $error');
    super.onError(bloc, error, stackTrace);
  }
}
