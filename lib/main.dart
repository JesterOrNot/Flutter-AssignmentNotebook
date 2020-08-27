import 'package:assignment_notebook/AppBody.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: AppBody(),
    );
  }
}
