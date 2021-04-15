import 'package:address_book/providers/great_places.dart';
import 'package:address_book/screens/add_place_screen.dart';
import 'package:address_book/screens/place_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/place_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GreatPlaces>(
      create: (_) => GreatPlaces(),
      child: MaterialApp(
        title: 'address_book',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlaceListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
