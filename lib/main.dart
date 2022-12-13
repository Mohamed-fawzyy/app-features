import 'package:app_features/provider/greate_place.dart';
import 'package:app_features/screens/add_place_screen.dart';
import 'package:app_features/screens/place_details_screen.dart';
import 'package:app_features/screens/place_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatePlace(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Great Places',
        theme: ThemeData(
          colorSchemeSeed: const Color.fromARGB(255, 25, 88, 140),
        ),
        home: const PlaceListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => const AddPlaceScreen(),
          PlaceDetailsScreen.routeName: (context) => const PlaceDetailsScreen()
        },
      ),
    );
  }
}
