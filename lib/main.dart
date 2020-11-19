import 'package:assignment_notebook/AppBody.dart';
import 'package:flutter/material.dart';
import 'package:assignment_notebook/globals.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    appTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBook',
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      themeMode: appTheme.currentTheme(),
      debugShowCheckedModeBanner: false,
      home: AppBody(),
    );
  }
}
