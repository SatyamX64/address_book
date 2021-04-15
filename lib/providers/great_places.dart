import 'dart:io';

import 'package:address_book/helpers/db_helper.dart';
import 'package:address_book/models/place.dart';
import 'package:flutter/material.dart';

class GreatPlaces extends ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  void addPlace({String title, File image, PlaceLocation location}) {
    final place = Place(
        id: DateTime.now().toIso8601String(),
        image: image,
        title: title,
        location: location);
    _items.add(place);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'loc_lat': place.location.latitude,
      'loc_lng': place.location.longitude,
      'address': place.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
