import 'package:assignment_notebook/home.dart';
import 'package:assignment_notebook/schedule.dart';
import 'package:assignment_notebook/tasks.dart';
import 'package:flutter/material.dart';

import 'globals.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppBody(),
    );
  }
}

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterBook"),
      ),
      bottomNavigationBar: StreamBuilder(
        stream: state.stream$,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            currentIndex: snapshot.data ?? 1,
            onTap: (index) {
              state.setIndex(index);
              state.getController().animateToPage(index,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.check_box),
                title: Text("Tasks"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                title: Text("Schedule"),
              ),
            ],
          );
        },
      ),
      body: PageView(
        controller: state.getController(),
        onPageChanged: (index) {
          state.setIndex(index);
        },
        children: [
          TaskPage(),
          HomePage(),
          SchedulePage(),
        ],
      ),
    );
  }
}
