import 'package:city_temp/blocs/weather_bloc.dart';
import 'package:city_temp/blocs/weather_events.dart';
import 'package:city_temp/data/prefs.dart';
import 'package:city_temp/data/weather_service.dart';
import 'package:city_temp/screens/temps_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  final _prefs = Prefs();
  await _prefs.init();

  final _prefsProvider = Provider<Prefs>(create: (_) => _prefs);

  final _weatherServiceProvider =
      Provider<WeatherService>(create: (_) => WeatherService());

  final _weatherBlocProvider = BlocProvider(create: (_) => WeatherBloc());

  runApp(MultiProvider(
    providers: [
      _prefsProvider,
      _weatherServiceProvider,
      _weatherBlocProvider,
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final _prefs = Prefs();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: readCitiesPrefs(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          BlocProvider.of<WeatherBloc>(context)
              .add(CitiesLoaded(cityNames: snapshot.data));
        }
        return MaterialApp(
          title: 'City Temps',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: TempsScreen(),
        );
      },
    );
  }

  Future<List<String>> readCitiesPrefs() async {
    // add some delay so the state change is visible
    await Future.delayed(Duration(milliseconds: 1200));
    return _prefs.getCities();
  }
}
