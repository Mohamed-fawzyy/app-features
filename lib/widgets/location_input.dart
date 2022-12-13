import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:app_features/helpers/location_helper.dart';
import 'package:app_features/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key, required this.onSelectPlace})
      : super(key: key);

  final Function onSelectPlace;
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double? lng, double? lat) {
    final mapImageUrl = LocationHelper.generateLocationImage(lng, lat);
    setState(() {
      _previewImageUrl = mapImageUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude, locData.longitude);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _selectOnMap() async {
    //future bec u have to wait the selected loc, that happened when u close the screen or poped it
    final selectedLoc = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const MapScreen(isSelecting: true),
      ),
    );
    if (selectedLoc == null) {
      return;
    }
    _showPreview(selectedLoc.latitude, selectedLoc.longitude);
    widget.onSelectPlace(selectedLoc.latitude, selectedLoc.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 175,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: _previewImageUrl == null
              ? const Text('No Location Chosen')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on_outlined),
              label: const Text('Current Location'),
              style: TextButton.styleFrom(
                textStyle: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map_sharp),
              label: const Text('Select On Map'),
              style: TextButton.styleFrom(
                textStyle: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        )
      ],
    );
  }
}
