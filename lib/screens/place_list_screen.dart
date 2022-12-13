import 'package:app_features/provider/greate_place.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/add-place');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatePlace>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatePlace>(
                child: const Center(
                  child: Text('No places added yet, Start adding!'),
                ),
                builder: (context, greatPlace, ch) => greatPlace.items.isEmpty
                    ? ch!
                    : ListView.builder(
                        itemCount: greatPlace.items.length,
                        itemBuilder: (context, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatPlace.items[i].image),
                          ),
                          title: Text(greatPlace.items[i].title),
                          onTap: () {},
                        ),
                      ),
              ),
      ),
    );
  }
}
