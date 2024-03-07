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

  void run() {
    if (state.status.isRunning) return;
    state = Watch(time: state.time, status: Status.running);

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!state.status.isRunning) {
        timer.cancel();
        return;
      }
      _countDown();
    });
  }

  void _countDown() {
    final current = state.time;
    state = Watch(time: current - 1, status: state.status);
  }

  void pause() {
    state = Watch(time: state.time, status: Status.pause);
  }

  void restart() {
    state = const Watch();
    run();
  }
}
