import 'package:flutter/material.dart';

class CountModel extends ChangeNotifier {
  int counter = 0;
  int secondCounter = 0;
  Color appBarColor = Colors.red.shade400;

  void incrementCounter() {
    counter++;
    notifyListeners();
  }

  void incrementSecondCounter() {
    secondCounter++;
    notifyListeners();
  }

  void changeColor(Color newColor) {
    appBarColor = newColor;
    notifyListeners();
  }
}
