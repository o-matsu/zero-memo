enum Status {
  ready,
  running,
  pause,
  ;

  Status get next => Status.values.elementAt((index + 1) % 3);
  bool get isRunning => this == Status.running;
}
