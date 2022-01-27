import 'package:flutter/material.dart';

class AddressChanger extends ChangeNotifier {
  int _counter = 0;
  int get count => _counter;

  displayResult(dynamic newValue) {
    _counter = newValue;
    notifyListeners();
  }
}
