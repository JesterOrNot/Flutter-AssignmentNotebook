import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasksState {
  BehaviorSubject _state = BehaviorSubject<List<String>>.seeded([]);
  Stream get stream$ => _state.stream;
  List<String> get assignments => _state.value;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController controller = TextEditingController();


  TasksState() {
    (() async {
      await getSharedPrefs();
    })();
  }

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _state.add(prefs.getStringList("assignments") ?? []);
  }

  setAssignments(List<String> value) {
    _state.add(value);
    setList(assignments);
  }

  removeAt(int index) {
    List<String> firstHalf = assignments.sublist(0, index);
    List<String> lastHalf = assignments.sublist(index + 1);
    firstHalf.addAll(lastHalf);
    _state.add(firstHalf);
    setList(firstHalf);
  }

  Future<Null> setList(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("assignments", list);
  }

  void handleSubmit(BuildContext context, String text) {
    if (text.length != 0) {
      assignments.add(text);
      this.setAssignments(assignments);
    }
    controller.clear();
    Navigator.of(context).pop();
  }

  void addAssignment(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add an Assignment!'),
          content: TextField(
              controller: controller,
              autofocus: true,
              onSubmitted: (String text) {
                handleSubmit(context, text);
                print(text);
              },),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                controller.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
