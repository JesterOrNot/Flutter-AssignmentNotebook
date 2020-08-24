import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class NavState {
  BehaviorSubject _state = BehaviorSubject.seeded(1);
  Stream get stream$ => _state.stream;
  int get index => _state.value;
  PageController controller = PageController(initialPage: 1);

  setIndex(int value) {
    _state.add(value);
  }

  PageController getController() {
    return controller;
  }
}
