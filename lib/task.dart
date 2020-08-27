import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final String text;

  Task({Key key, this.text}) : super(key: key);

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  String text;
  bool submitted;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    this.text = widget.text;
    this.submitted = true;
    this.controller = TextEditingController(text: this.text);
  }

  void edit(String newText) {
    Navigator.of(context).pop();
    if (text.length != 0) {
      setState(() {
        text = newText;
      });
    }
    controller.clear();
  }

  void displayEditDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Note!'),
            content: TextField(
              controller: controller,
              autofocus: true,
              onSubmitted: edit,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListTile(
            onLongPress: displayEditDialog,
            trailing: Icon(Icons.edit),
            title: Text(this.text)));
  }
}