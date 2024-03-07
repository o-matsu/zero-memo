import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zero_memo/src/features/watch/application/provider.dart';
import 'package:zero_memo/src/features/watch/domain/status.dart';

class WatchPage extends ConsumerWidget {
  const WatchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(watchDataProvider);

    return Scaffold(
      body: Center(
        child: timer(context, watch.time),
      ),
      floatingActionButton: button(ref, watch.status),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget button(WidgetRef ref, Status status) {
    final nty = ref.read(watchDataProvider.notifier);

    switch (status) {
      case Status.ready:
        return FloatingActionButton.large(
          onPressed: () => nty.run(),
          child: const Icon(Icons.play_arrow),
        );

      case Status.running:
        return FloatingActionButton.large(
          onPressed: () => nty.pause(),
          child: const Icon(Icons.stop),
        );

      case Status.pause:
        return FloatingActionButton.large(
          onPressed: () => nty.restart(),
          child: const Icon(Icons.play_arrow),
        );
    }
  }

  Widget timer(BuildContext context, int time) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              shape: BoxShape.circle,
            ),
            child: Center(child: Text(time.toString())),
          ),
        ),
        Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: CircularProgressIndicator(
              value: (60 - time) % 60 / 60,
              strokeWidth: 20,
            ),
          ),
        ),
      ],
    );
  }
}
