import 'package:flutter/material.dart';

class ConfirmDelete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm"),
      content: const Text("Are you sure you wish to delete this item?"),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text("DELETE"),
        ),
        FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("CANCEL"),
        ),
      ],
    );
  }
}
