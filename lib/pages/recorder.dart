import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:running_tracker/utils/handle_location.dart';

class Recorder extends StatefulWidget {
  const Recorder({super.key});

  @override
  State<Recorder> createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  late GoogleMapController _googleMapController;
  late LatLng _currentPosition;

  BitmapDescriptor markerIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);

  void _onMapCreated(GoogleMapController googleMapController) {
    _googleMapController = googleMapController;
  }

  void setMarker() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size.fromRadius(0.5)),
            "assets/nav.png")
        .then((icon) {
      setState(() {
        markerIcon = icon;
      });
    });
  }

  @override
  void initState() {
    // setMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocationData>(
        future: getCurrentLocation(),
        builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot) {
          if (snapshot.hasData) {
            _currentPosition =
                LatLng(snapshot.data!.latitude!, snapshot.data!.longitude!);

            return GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _currentPosition, zoom: 15.5),
              onMapCreated: _onMapCreated,
              markers: <Marker>{
                Marker(
                  markerId: const MarkerId("current location"),
                  position: _currentPosition,
                  rotation: snapshot.data!.heading!,
                  icon: markerIcon,
                ),
              },
            );
          } else if (snapshot.hasError) {
            return const Text("could not obtain current position");
          } else {
            return const Text("loading...");
          }
        });
  }
}
