import 'package:flutter_stream/stream_holder.dart';

class StreamValue<T> with StreamHolder<T?> {
  T _value;

  StreamValue(this._value);

  void setValue(T val) {
    _value = val;
    postJobBeforeUpdate();
    notify(value: _value);
  }

  void postJobBeforeUpdate() {}

  T get value => _value;
}