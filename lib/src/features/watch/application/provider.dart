import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zero_memo/src/features/watch/domain/model.dart';
import 'package:zero_memo/src/features/watch/domain/status.dart';

part 'provider.g.dart';

@riverpod
class WatchData extends _$WatchData {
  @override
  Watch build() {
    return const Watch();
  }

  void start() {
    if (state.status.isRunning) return;
    state = const Watch(status: Status.running);
    _run();
  }

  void pause() {
    state = Watch(time: state.time, status: Status.stop);
  }

  void _run() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.status.isRunning) {
        _countDown();
        if (state.time < 0 && state.status == Status.running) {
          state = Watch(time: state.time, status: Status.timeout);
        }
      } else {
        timer.cancel();
      }
    });
  }

  void _countDown() {
    final current = state.time;
    state = Watch(time: current - 1, status: state.status);
  }
}
