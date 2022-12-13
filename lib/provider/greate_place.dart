import 'dart:io';

import 'package:app_features/helpers/db_helper.dart';
import 'package:app_features/helpers/location_helper.dart';
import 'package:app_features/models/place.dart';
import 'package:flutter/material.dart';

class GreatePlace with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
    String pickedTitle,
    File pickedImage,
    PlaceLocation? pickedLoc,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
      pickedLoc!.latitude,
      pickedLoc.longitude,
    );
    final updatedLocation = PlaceLocation(
      latitude: pickedLoc.latitude,
      longitude: pickedLoc.longitude,
      address: address,
    );

    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: updatedLocation,
      image: pickedImage,
    );
    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'loc_lat': newPlace.location!.latitude,
        'loc_lng': newPlace.location!.longitude,
        'address': newPlace.location!.address,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
            image: File(item['image']),
          ),
        )
        .toList();
  }
}
