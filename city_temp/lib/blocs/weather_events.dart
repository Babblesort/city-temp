abstract class WeatherEvent {}

class CitiesLoaded extends WeatherEvent {
  final List<String> cityNames;
  CitiesLoaded({required this.cityNames});
}

class CityAdded extends WeatherEvent {
  final String cityName;
  CityAdded({required this.cityName});
}

class CityRemoved extends WeatherEvent {
  final String cityName;
  CityRemoved({required this.cityName});
}
