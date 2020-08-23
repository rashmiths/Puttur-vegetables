import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:puttur_vegetables/widgets/custom_appBar.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  List<Marker> allMarkers = [];
  Completer<GoogleMapController> _controller = Completer();
  bool normalMap = false;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
      12.755296,
      75.212454,
    ),
    zoom: 10,
  );
  @override
  void initState() {
    allMarkers.add(Marker(
        markerId: MarkerId('shopLocation'),
        draggable: true,
        onTap: () {
          print('TAPPED');
        },
        position: LatLng(
          12.755296,
          75.212454,
        )));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomAppBar(
        'MAPS',
        false,
        false,
        true,
        page: 'MapScreen',
      ),
      body: GoogleMap(
        markers: Set.from(allMarkers),
        mapType: normalMap ? MapType.normal : MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _currentLocation,
      //   label: Text('My Location'),
      //   icon: Icon(Icons.location_on),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        visible: true,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.location_on),
            backgroundColor: Colors.red,
            label: 'My Location',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => _currentLocation(),
          ),
          SpeedDialChild(
            child: Icon(Icons.shopping_basket),
            backgroundColor: Colors.blue,
            label: 'Shop',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => _shopLocation(),
          ),
          SpeedDialChild(
            child: Icon(Icons.map),
            backgroundColor: Colors.blue,
            label: (!normalMap) ? 'Normal Map' : 'Hybrid Map',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              setState(() {
                normalMap = !normalMap;
              });
            },
          ),
        ],
      ),
    );
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 17.0,
      ),
    ));
  }

  void _shopLocation() async {
    final GoogleMapController controller = await _controller.future;
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(
          12.755296,
          75.212454,
        ),
        zoom: 17.0,
      ),
    ));
  }
}
