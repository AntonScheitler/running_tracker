import "package:flutter/material.dart";

class Tracker extends StatefulWidget {
  const Tracker({super.key});

  @override
  State<Tracker> createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        heightFactor: 3,
        child: Column(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Text("test1"), Text("test2"), Text("test3")],
              ),
            ),
            ElevatedButton(
                onPressed: () {}, child: const Text("start tracking")),
            ElevatedButton(
                onPressed: () {}, child: const Text("pause tracking")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("stop tracking")),
          ],
        ),
      ),
    );
  }
}
