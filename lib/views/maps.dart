import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mavel_comics/widgets/circular_waiting.dart';
import 'package:mavel_comics/widgets/my_dialogs.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  GoogleMapController _controller;
  Set<Marker> markers = Set<Marker>();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-7.220693, -39.3277049),
    zoom: 17,
  );

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _sendAddress(Placemark place) {
    MyDialogs.yesNo(
      context: context,
      title: 'Warning',
      message: 'Send comic to: ${place.street}, '
          // '${place.subAdministrativeArea} - '
          '${place.administrativeArea} '
          '${place.country}?',
      onYes: () {
        Navigator.of(context).pop();
        MyDialogs.showToast(context, 'Comic will be send!');
      },
    );
  }

  void _moveCamera(LatLng myPosition) {
    final Marker marker = Marker(
      markerId: MarkerId('myLocation'),
      position: myPosition,
    );

    setState(() {
      markers.add(marker);
    });

    _controller.moveCamera(CameraUpdate.newLatLng(myPosition));
  }

  void _getMyLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      Geolocator.requestPermission();
    }

    if (await Geolocator.isLocationServiceEnabled()) {
      CircularWaiting myCircular = CircularWaiting(
        context,
        message: 'Getting Position',
      );

      myCircular.show();

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: true);

      myCircular.close();

      LatLng myPosition = LatLng(position.latitude, position.longitude);

      _moveCamera(myPosition);

      Placemark place = await _getAddressByLocation(myPosition);

      _sendAddress(place);
    } else {
      MyDialogs.show(
        context,
        'Location Service is diasble!',
        title: 'Warning',
      );
    }
  }

  void _getLocationByAddress(String address) async {
    GeocodingPlatform geocoding = GeocodingPlatform.instance;
    List<Location> addresses = await geocoding.locationFromAddress(address);

    LatLng myPosition =
        LatLng(addresses.first.latitude, addresses.first.longitude);

    _moveCamera(myPosition);

    Placemark place = await _getAddressByLocation(myPosition);

    _sendAddress(place);
  }

  Future<Placemark> _getAddressByLocation(LatLng myPosition) async {
    GeocodingPlatform geocoding = GeocodingPlatform.instance;
    List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(
        myPosition.latitude, myPosition.longitude);

    return placemarks[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
          onSubmitted: (String value) => _getLocationByAddress(value),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: GoogleMap(
          zoomControlsEnabled: false,
          onMapCreated: _onMapCreated,
          // onTap: _onTap,
          markers: markers,
          initialCameraPosition: _kGooglePlex,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getMyLocation,
        child: Icon(Icons.my_location),
      ),
    );
  }
}
