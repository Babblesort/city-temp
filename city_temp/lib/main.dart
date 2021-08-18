import 'package:city_temp/data/city_weather.dart';
import 'package:city_temp/screens/temps_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/temps_state.dart';

void main() {
  runApp(StreamProvider<List<CityWeather>>(
      create: (_) => TempsState().cityWeathers,
      initialData: [],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'City Temps',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TempsScreen(),
    );
  }
}
