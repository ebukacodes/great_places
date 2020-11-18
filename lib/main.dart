import 'package:flutter/material.dart';
import 'package:great_places/screens/place_details_screen.dart';
import 'package:provider/provider.dart';
import './providers/great_places.dart';
import './screens/place_list_screen.dart';
import './screens/add_place_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.lime,
        ),
        home: PlaceListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailsScreen.routeName: (ctx) => PlaceDetailsScreen(),
        },
      ),
    );
  }
}
