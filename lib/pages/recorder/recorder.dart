import 'package:flutter/material.dart';
import './tracker.dart';

class Recorder extends StatelessWidget {
  const Recorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 4,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Tracker()));
        },
        child: const Text("start tracker"),
      ),
    );
  }
}
