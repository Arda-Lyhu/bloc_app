import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/core.dart';

/// Global BLoC lifecycle and transition observer.
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    AppLogger.debug('BLoC', 'Created: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    AppLogger.info('BLoC Event', '${bloc.runtimeType} ➔ $event');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    AppLogger.debug('BLoC State',
        '${bloc.runtimeType}: ${change.currentState} ➔ ${change.nextState}');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    AppLogger.error('BLoC Error', 'Error in ${bloc.runtimeType}',
        error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    AppLogger.debug('BLoC', 'Closed: ${bloc.runtimeType}');
  }
}
