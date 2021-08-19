import 'package:city_temp/data/city_weather.dart';
import 'package:flutter/foundation.dart';

class TempsState extends ChangeNotifier {
  List<CityWeather> cityWeathers = <CityWeather>[];

  void addCity(String cityName) {
    cityWeathers.add(CityWeather(city: cityName));
    notifyListeners();
  }

  void clearCities() {
    cityWeathers.clear();
    notifyListeners();
  }

  TempsState() {
    cityWeathers = [
      CityWeather(city: 'Chicago'),
      CityWeather(city: 'Atlanta'),
      CityWeather(city: 'Denver')
    ];
  }
}
