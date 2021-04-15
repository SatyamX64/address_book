import 'package:address_book/providers/great_places.dart';
import 'package:address_book/screens/add_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'place_detail_screen.dart';

class PlaceListScreen extends StatelessWidget {
  static const routeName = 'place-list-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Places'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, AddPlaceScreen.routeName);
              })
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    child: Center(
                      child: Text('No Data Added'),
                    ),
                    builder: (_, greatPlaces, child) {
                      if (greatPlaces.items.length == 0)
                        return child;
                      else
                        return ListView.builder(
                          itemCount: greatPlaces.items.length,
                          itemBuilder: (_, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.items[index].image),
                              ),
                              title: Text(greatPlaces.items[index].title),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  PlaceDetailScreen.routeName,
                                  arguments: greatPlaces.items[index].id,
                                );
                              },
                            );
                          },
                        );
                    },
                  ),
      ),
    );
  }
}
