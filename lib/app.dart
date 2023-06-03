import 'package:flutter/material.dart';
import 'package:running_tracker/pages/history.dart';
import 'package:running_tracker/pages/recorder/recorder.dart';
import 'package:running_tracker/pages/feed.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  final List<Widget> _pages = [const Feed(), const Recorder(), const History()];
  int _index = 1;

  void _onTap(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Running Tracker")),
        ),
        body: _pages.elementAt(_index),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted_rounded), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: ""),
          ],
          currentIndex: _index,
          onTap: _onTap,
        ),
      ),
    );
  }
}
