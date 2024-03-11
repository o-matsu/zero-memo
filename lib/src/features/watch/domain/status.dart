enum Status {
  stop,
  running,
  timeout,
  ;

  bool get isRunning => this != Status.stop;
}
