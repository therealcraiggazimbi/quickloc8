import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/models/vehicle_markers.dart';
import 'package:untitled/screens/messages_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  BitmapDescriptor makerIcon = BitmapDescriptor.defaultMarker;

  loadBitmap() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(50, 50)),
            "assets/ic_new_white_taxi.png")
        .then((value) {
      setState(() {
        makerIcon = value;
      });
    });
    debugPrint("Done loading");
  }

  @override
  void initState() {
    loadBitmap();
    super.initState();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-33.876115, 18.5008116),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    // List<VehicleMarker> markers = loadMarkers();
// loadBitmap();
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,

        initialCameraPosition: _initialPosition,
        markers: loadMarkers(),
        // markers: {
        //   Marker(
        //     markerId: MarkerId("sdemo"),
        //     position: LatLng(-33.9685533, 18.5662383),
        //     icon: makerIcon
        //   ),
        // },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.message),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MessagesScreen(),
            ),
          );
        },
      ),
    );
  }

  Set<Marker> loadMarkers() {
    List<VehicleMarker> markers = [];
    Set<Marker> markerSet = {};

    for (var e in vms) {
      debugPrint(e.toString());
      markerSet.add(
        Marker(
            markerId: const MarkerId("Position"),
            icon: makerIcon,
            position: LatLng(
              double.parse("${e['latitude']}"),
              double.parse("${e['longitude']}"),
            ),
            rotation: double.parse('${e["heading"]}')),
      );
    }

    return markerSet;
  }
}

const vms = [
  {"heading": "31", "latitude": "-33.876115", "longitude": "18.5008116"},
  {"heading": "310", "latitude": "-33.9685533", "longitude": "18.5662383"},
  {"heading": "0", "latitude": -34.0461583, "longitude": 18.7047383},
  {"heading": "0", "latitude": "-31.8994016", "longitude": "26.8671716"},
  {"heading": "299", "latitude": -31.8942983, "longitude": 26.878175},
  {"heading": "43", "latitude": -31.9998233, "longitude": 27.5801216}
];
