import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter.g.dart';

@riverpod
class Counter extends _$Counter {
  int counter = 0;

  @override
  int build() => 0;

  void incrementCounter() {
    state++;
  }

  void decrementCounter() {
    state--;
  }

  void resetCounter() {
    state = 0;
  }

  void multiplayCounter() {
    state *= state;
  }
}
