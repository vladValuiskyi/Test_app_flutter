import 'dart:async';
import 'package:test_app/api/api.dart';

import './models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMap extends StatefulWidget {
  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
          future: ApiRequests().getUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GoogleMap(
                markers: createMarkers(snapshot.data),
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  zoom: 0,
                  target: LatLng(0, 0),
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Set<Marker> createMarkers(List<User> snapshot) {
    List<User> users = snapshot;
    List<Marker> markers = [];
    for (User user in users) {
      double userLat = double.tryParse(user.address.geo.lat);
      double userLng = double.tryParse(user.address.geo.lng);
      markers.add(Marker(
        markerId: MarkerId(user.id.toString()),
        position: LatLng(userLat, userLng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(title: user.name),
      ));
    }
    return Set.from(markers);
  }
}
