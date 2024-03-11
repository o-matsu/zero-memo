import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zero_memo/src/features/watch/domain/model.dart';
import 'package:zero_memo/src/features/watch/domain/status.dart';

class Timer extends StatelessWidget {
  final double radius = 300;
  final double stroke = 10;
  final Watch watch;
  final Function onTap;
  const Timer({
    super.key,
    required this.watch,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (watch.time == 0) {
      HapticFeedback.vibrate();
    }
    return Stack(
      children: [
        Center(
          child: Ink(
            width: radius + stroke,
            height: radius + stroke,
            decoration: BoxDecoration(
              color: getContainerColor(context, watch.status),
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(2, 10),
                  blurRadius: 10.0,
                  blurStyle: BlurStyle.solid,
                ),
              ],
            ),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                HapticFeedback.lightImpact();
                onTap();
              },
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(getIcon(watch.status)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (watch.time < 0) ...{
                          Text(
                            '\u25B2 ',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        },
                        Text(
                          '${watch.time.abs()}',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        IgnorePointer(
          child: Center(
            child: SizedBox(
              width: radius,
              height: radius,
              child: CircularProgressIndicator(
                value: (60 - watch.time) % 60 / 60,
                strokeWidth: stroke,
                color: getColor(context, watch.status),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color getColor(BuildContext context, Status status) {
    final scheme = Theme.of(context).colorScheme;

    switch (status) {
      case Status.stop:
        return scheme.outline;
      case Status.running:
        return scheme.primary;
      case Status.timeout:
        return scheme.error;
    }
  }

  Color getContainerColor(BuildContext context, Status status) {
    final scheme = Theme.of(context).colorScheme;

    switch (status) {
      case Status.stop:
        return scheme.outlineVariant;
      case Status.running:
        return scheme.primaryContainer;
      case Status.timeout:
        return scheme.errorContainer;
    }
  }

  IconData getIcon(Status status) {
    switch (status) {
      case Status.stop:
        return Icons.hourglass_empty_rounded;
      case Status.running:
        return Icons.hourglass_top_rounded;
      case Status.timeout:
        return Icons.hourglass_bottom_rounded;
    }
  }
}
