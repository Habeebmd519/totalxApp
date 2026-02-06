import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totelxapp/blocs/timer_cubit/timer_state.dart';

class TimerBloc extends Cubit<TimerState> {
  Timer? _timer;

  TimerBloc() : super(TimerState(seconds: 59, isRunning: true)) {
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    emit(TimerState(seconds: 59, isRunning: true));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.seconds > 0) {
        emit(TimerState(seconds: state.seconds - 1, isRunning: true));
      } else {
        _timer?.cancel();
        emit(TimerState(seconds: 0, isRunning: false));
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
