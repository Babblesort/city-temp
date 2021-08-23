import 'package:city_temp/blocs/weather_bloc.dart';
import 'package:city_temp/blocs/weather_events.dart';
import 'package:city_temp/screens/temps_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  runApp(BlocProvider(
    create: (context) {
      final WeatherBloc bloc = WeatherBloc();
      bloc.add(WeatherLoaded());
      return bloc;
    },
    child: MyApp(),
  ));
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
