import 'dart:io';

import 'package:app_features/models/place.dart';
import 'package:app_features/provider/greate_place.dart';
import 'package:app_features/widgets/image_input.dart';
import 'package:app_features/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});
  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocatoin;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocatoin = PlaceLocation(latitude: lat, longitude: lng, address: '');
  }

  void onSaved() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocatoin == null) {
      return;
    }
    Provider.of<GreatePlace>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage!,
      _pickedLocatoin,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _titleController,
                    ),
                    const SizedBox(height: 10),
                    ImageInput(_selectImage),
                    const SizedBox(height: 20),
                    LocationInput(onSelectPlace: _selectPlace),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: onSaved,
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            label: const Text(
              'Add Place',
              style: TextStyle(color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(193, 255, 191, 0),
              fixedSize: const Size(0, 50),
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
