import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail-screen';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 250,
              width: double.infinity,
              child: Image.file(
                selectedPlace.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              selectedPlace.location.address,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 25,
                width: double.infinity,
               
                child: ListTile(
                  leading: Text(
                    'Longitude : ${selectedPlace.location.longitude}',
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 25,
                width: double.infinity,
               
                child: ListTile(
                  leading: Text(
                    'Longitude : ${selectedPlace.location.latitude}',
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
