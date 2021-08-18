import 'dart:async';
import 'package:city_temp/data/city_weather.dart';

class TempsState {
  final List<CityWeather> _cityWeathers = List.from([
    CityWeather(city: 'Chicago'),
    CityWeather(city: 'Atlanta'),
    CityWeather(city: 'Denver')
  ]);

  StreamController<List<CityWeather>> _cityWeathersController =
      StreamController.broadcast();

  Stream<List<CityWeather>> get cityWeathers => _cityWeathersController.stream;

  TempsState() {
    _cityWeathersController.onListen = () {
      _cityWeathersController.add(_cityWeathers);
    };
  }
}
