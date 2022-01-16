import 'dart:async';

mixin StreamHolder<T> {
  final StreamController<T?> _controller = StreamController<T?>.broadcast();

  Stream<T?> get on => _controller.stream;

  void dispose() => _controller.close();

  notify({T? value}) {
    if (_controller.isClosed) {
      return;
    }
    _controller.sink.add(value);
  }

  bool get isClosed => _controller.isClosed;
}
