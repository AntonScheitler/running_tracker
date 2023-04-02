import "package:flutter/material.dart";
import "package:running_tracker/app.dart";

void main() {
  runApp(const RunningTracker());
}

class RunningTracker extends StatelessWidget {
  const RunningTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: App(),
    );
  }
}
