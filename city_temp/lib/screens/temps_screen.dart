import 'package:city_temp/data/city_weather.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TempsScreen extends StatelessWidget {
  const TempsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var weathers = Provider.of<List<CityWeather>>(context);

    List<Widget> weatherTiles =
        weathers.map((e) => ListTile(title: Text(e.city))).toList();

    return Scaffold(
      appBar: AppBar(title: Text('City Temps')),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(children: weatherTiles),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
