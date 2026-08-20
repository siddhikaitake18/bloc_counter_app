import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(count: 0)) {
    on<Increment>((event, emit) {
      if (state.count < 10) {
        emit(CounterState(count: state.count + 1));
      }
    });

    on<Decrement>((event, emit) {
      if (state.count > 0) {
        emit(CounterState(count: state.count - 1));
      }
    });

    on<Reset>((event, emit) {
      emit(CounterState(count: 0));
    });
  }
}