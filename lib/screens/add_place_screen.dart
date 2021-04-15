import 'dart:async';
import 'dart:io';

import 'package:address_book/models/place.dart';
import 'package:address_book/providers/great_places.dart';
import 'package:address_book/widgets/image_input.dart';
import 'package:address_book/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = 'add-place-screen';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  TextEditingController _titleController;
  TextEditingController _addressController;
  File selectedImage;
  PlaceLocation currentLocation;
  GreatPlaces _greatPlaces;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _addressController = TextEditingController();
    _greatPlaces = Provider.of<GreatPlaces>(context, listen: false);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  savePlace() {
    if (_titleController.text.isEmpty ||
        selectedImage == null ||
        currentLocation == null) {
      return;
    } else {
      _greatPlaces.addPlace(
          title: _titleController.text,
          image: selectedImage,
          location: PlaceLocation(
              latitude: currentLocation.latitude,
              longitude: currentLocation.longitude,
              address: (_addressController.text ?? 'No address specified')));
      Navigator.pop(context);
    }
  }

  setImage(File pickedImage) {
    selectedImage = pickedImage;
  }

  setLocation(PlaceLocation location) {
    currentLocation = location;
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Address'),
                      controller: _addressController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(setImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(setLocation),
                  ],
                ),
              ),
            ),
          ),
          MaterialButton(
            color: Theme.of(context).accentColor,
            onPressed: savePlace,
            child: Text('Add Place'),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
