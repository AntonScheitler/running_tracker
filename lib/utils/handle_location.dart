import 'package:location/location.dart';

void setupLocation() async {
  Location location = Location();

  late bool serviceEnabled;
  late PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
  }
  if (!serviceEnabled) {
    return;
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
  }
  if (permissionGranted != PermissionStatus.granted) {
    return;
  }
}

Future<LocationData> getCurrentLocation() {
  setupLocation();
  return Location().getLocation();
}

Location getLocation() {
  setupLocation();
  return Location();
}
