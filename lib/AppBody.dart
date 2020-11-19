import 'package:assignment_notebook/KeepAlivePage.dart';
import 'package:assignment_notebook/SearchBar.dart';
import 'package:assignment_notebook/home.dart';
import 'package:assignment_notebook/schedule.dart';
import 'package:assignment_notebook/tasks.dart';
import 'package:flutter/material.dart';

import 'package:assignment_notebook/globals.dart';

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterBook"),
        actions: <Widget>[
          IconButton(
             icon: Icon(Icons.wb_sunny),
             tooltip: "Switch themes!",
             onPressed: () {
               appTheme.switchTheme();
             },
          )
        ],
      ),
      bottomNavigationBar: StreamBuilder(
        stream: navState.stream$,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            currentIndex: snapshot.data ?? 1,
            onTap: (index) {
              navState.setIndex(index);
              navState.getController().animateToPage(index,
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
        controller: navState.getController(),
        onPageChanged: (index) {
          navState.setIndex(index);
        },
        children: [
          KeepAlivePage(
            child: TaskPage(),
          ),
          KeepAlivePage(
            child: HomePage(),
          ),
          KeepAlivePage(
            child: SchedulePage(),
          ),
        ],
      ),
    );
  }
}
