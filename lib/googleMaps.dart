/*import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_project/models/location.dart';
import 'package:mobile_project/models/location.dart' as locations;

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Map<String, Marker> _marker = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _marker.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _marker[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: const LatLng(0, 0),
            zoom: 2.0,
          ),
          markers: _marker.values.toSet(),
        ),
      ),
    );
  }
}
*/
