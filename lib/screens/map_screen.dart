import 'package:app_features/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  //must be const bec it an init val so u have to prevent change the val in runtime
  const MapScreen({
    super.key,
    this.initialLocation = const PlaceLocation(
      latitude: 23.453,
      longitude: -174.563,
      address: 'egy',
    ),
    this.isSelecting = false, //used for (a)pick a loc (b) show a loc
  });
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // ignore: prefer_const_constructors
  LatLng _pickedLocation = LatLng(0, 0); //try make it final
  bool _pickedLocationCondition() {
    if (_pickedLocation.latitude == 0 && _pickedLocation.longitude == 0) {
      return false;
    } else {
      return true;
    }
  }

  void _selectedLocation(LatLng positon) {
    setState(() {
      _pickedLocation = positon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocationCondition() //icon yban lma y7ot marker
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: const Icon(Icons.done),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectedLocation : null,
        markers: _pickedLocationCondition()
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation,
                ),
              },
      ),
    );
  }
}
