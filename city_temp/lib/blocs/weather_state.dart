import 'package:city_temp/data/city_weather.dart';

abstract class WeatherState {}

class WeatherLoadInProgress extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  final List<CityWeather> weathers;
  WeatherLoadSuccess({this.weathers = const []});
}

class WeatherLoadFailure extends WeatherState {}
