import 'package:app_scale/features/test/bloc/counter_event.dart';
import 'package:bloc/bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncremented>(
      (event, emit) => emit(state + 1),
    );
    on<CounterDecremented>(
      (event, emit) => emit(state - 1),
    );
  }
}
