import 'package:zero_memo/src/features/watch/domain/status.dart';

class Watch {
  final int time;
  final Status status;
  const Watch({
    this.time = 60,
    this.status = Status.ready,
  });
}
