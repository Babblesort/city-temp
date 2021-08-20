import 'package:city_temp/data/city_weather.dart';

abstract class WeatherEvent {}

class WeatherLoaded extends WeatherEvent {
  @override
  String toString() => 'WeatherLoaded {}';
}

class WeatherAdded extends WeatherEvent {
  final CityWeather weather;
  WeatherAdded(this.weather);

  @override
  String toString() => 'WeatherAdded {city: $weather.city}';
}
