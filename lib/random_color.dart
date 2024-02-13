import 'dart:math';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'random_color.g.dart';

@riverpod
class RandomColor extends _$RandomColor {
  @override
  Color build() => Colors.black;

  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
  ];

  void randomColor() {
    state = colors[Random().nextInt(colors.length)];
  }
}
