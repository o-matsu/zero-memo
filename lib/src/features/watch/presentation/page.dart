import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zero_memo/src/features/watch/application/provider.dart';
import 'package:zero_memo/src/features/watch/presentation/timer.dart';

class WatchPage extends ConsumerWidget {
  const WatchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(watchDataProvider);

    return Scaffold(
      body: Center(
        child: Timer(
          watch: watch,
          onTap: () => fire(ref, watch.status.isRunning),
        ),
      ),
      floatingActionButton: Text(watch.status.name),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void fire(WidgetRef ref, bool running) {
    print('fire:$running');
    final nty = ref.read(watchDataProvider.notifier);
    if (running) {
      nty.pause();
    } else {
      nty.start();
    }
  }
}
