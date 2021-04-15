import 'package:address_book/models/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  double longitude;
  double latitude;

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      widget.onSelectPlace(PlaceLocation(
          latitude: locData.latitude, longitude: locData.longitude));
      setState(() {
        longitude = locData.longitude;
        latitude = locData.latitude;
      });
    } catch (error) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: ListTile(
              leading: Text(
                'Longitude : $longitude',
              ),
            )),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: ListTile(
              leading: Text(
                'Longitude : $latitude',
              ),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              icon: Icon(
                Icons.location_on,
              ),
              label: Text('Pick Current Location'),
              onPressed: _getCurrentUserLocation,
            ),
          ],
        ),
      ],
    );
  }
}
