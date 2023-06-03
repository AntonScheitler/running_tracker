import "dart:async";
import "dart:math";

import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "../../utils/handle_location.dart";
import "package:location/location.dart";

class Tracker extends StatefulWidget {
  const Tracker({super.key});

  @override
  State<Tracker> createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  late Timer timer;
  bool running = false;

  Duration duration = Duration.zero;
  double speed = 0.0;
  late LatLng lastPosition;
  double distance = 0.0;

  void startTracking() {
    if (!running) {
      getCurrentLocation().then((location) {
        lastPosition = LatLng(location.latitude!, location.longitude!);
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            duration = Duration(seconds: duration.inSeconds + 1);
            getCurrentLocation().then((currentPosition) {
              speed = currentPosition.speed!;
              double p1 = lastPosition.latitude / 180;
              double p2 = currentPosition.latitude! / 180;
              double l1 = lastPosition.longitude / 180;
              double l2 = currentPosition.longitude! / 180;

              distance += (2 * 6378137.00) *
                  sqrt(pow(sin((p2 - p1) / 2), 2) +
                      (cos(p1) * cos(p2) * pow(sin((l2 - l1) / 2), 2)));

              lastPosition =
                  LatLng(currentPosition.latitude!, currentPosition.longitude!);
            });
          });
        });
      });

      running = true;
    }
  }

  void pauseTracking() {
    timer.cancel();
    running = false;
  }

  void stopTracking() {
    timer.cancel();
    setState(() {
      duration = Duration.zero;
      speed = 0.0;
      distance = 0.0;
    });
    running = false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        heightFactor: 3,
        child: Column(
          children: [
            Center(
              child: Wrap(
                spacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  Text(speed.toStringAsFixed(1)),
                  Text(distance.toStringAsFixed(0)),
                  Text(duration.inSeconds.toString())
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  startTracking();
                },
                child: const Text("start tracking")),
            ElevatedButton(
                onPressed: () {
                  pauseTracking();
                },
                child: const Text("pause tracking")),
            ElevatedButton(
                onPressed: () {
                  stopTracking();
                },
                child: const Text("stop tracking")),
          ],
        ),
      ),
    );
  }
}
