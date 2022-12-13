import 'package:app_features/provider/greate_place.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'map_screen.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final selectedPlace = Provider.of<GreatePlace>(
      context,
      listen: false,
    ).getPlaceByID(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              width: double.infinity,
              selectedPlace.image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Text(selectedPlace.location!.address),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => MapScreen(
                    initialLocation: selectedPlace.location,
                    isSelecting: true,
                  ),
                ),
              );
            },
            child: const Text('View On Map'),
          ),
        ],
      ),
    );
  }
}
