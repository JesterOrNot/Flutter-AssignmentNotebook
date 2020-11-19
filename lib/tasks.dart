import 'package:assignment_notebook/confirm_delete.dart';
import 'package:assignment_notebook/globals.dart';
import 'package:assignment_notebook/task.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: tasksState.stream$,
      initialData: [],
      builder: (context, snapshot) {
        return Scaffold(
          body: ListView.builder(
            itemCount: snapshot.data.length ?? 0,
            itemBuilder: (context, index) {
              final item = snapshot.data[index];
              return Dismissible(
                key: Key(item),
                confirmDismiss: (DismissDirection direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmDelete();
                    },
                  );
                },
                child: Task(
                  text: snapshot.data[index],
                ),
                onDismissed: (direction) => {
                  tasksState.removeAt(index)
                },
              );
            },
            shrinkWrap: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              tasksState.addAssignment(context);
              print(snapshot.data);
            },
            tooltip: 'Add Assignment',
            child: Icon(Icons.add),
          ),
        );
      }
    );
  }
}
