import 'package:assignment_notebook/task.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TextEditingController controller = TextEditingController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<String> _assignments;

  @override
  void initState() {
    super.initState();
    _assignments = [];
    (() async {
      await getSharedPrefs();
    })();
  }

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _assignments = prefs.getStringList("assignments") ?? [];
    });
  }

  Future<Null> setList(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("assignments", list);
  }

  void handleSubmit(String text) {
    controller.clear();
    if (text.length != 0) {
      setState(() {
        _assignments = [..._assignments, text];
      });
      setList(_assignments);
    }
    print(_assignments);
    Navigator.of(context).pop();
  }

  void _addAssignment() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add an Assignment!'),
            content: TextField(
              controller: controller,
              autofocus: true,
              onSubmitted: handleSubmit,
            ),
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          itemCount: _assignments.length,
          itemBuilder: (context, index) {
            final item = _assignments[index];
            return Dismissible(
              key: Key(item),
              confirmDismiss: (DismissDirection direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm"),
                      content: const Text(
                          "Are you sure you wish to delete this item?"),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("DELETE")),
                        FlatButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("CANCEL"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Task(text: _assignments[index]),
              onDismissed: (direction) => {
                setState(() {
                  _assignments.removeAt(index);
                })
              },
            );
          },
          shrinkWrap: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addAssignment,
          tooltip: 'Add Assignment',
          child: Icon(Icons.add),
        ));
  }
}
