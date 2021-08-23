abstract class WeatherState {}

class LoadCitiesInProgress extends WeatherState {}

class LoadCitiesSuccess extends WeatherState {
  final List<String> cityNames;
  LoadCitiesSuccess({this.cityNames = const []});
}

class LoadCitiesFailure extends WeatherState {}
