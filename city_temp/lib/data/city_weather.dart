class CityWeather {
  String city = '';
  String description = '';
  double temperature = 0;
  double perceivedTemperature = 0;
  int pressure = 0;
  int humidity = 0;

  CityWeather(
      {this.city = '',
      this.description = '',
      this.temperature = 0,
      this.perceivedTemperature = 0,
      this.pressure = 0,
      this.humidity = 0});

  CityWeather.fromJson(Map<String, dynamic> weatherMap) {
    this.city = weatherMap['name'];
    this.temperature = (weatherMap['main']['temp'] * (9 / 5) - 459.67) ?? 0;
    this.perceivedTemperature =
        (weatherMap['main']['feels_like'] * (9 / 5) - 459.67) ?? 0;
    this.pressure = weatherMap['main']['pressure'] ?? 0;
    this.humidity = weatherMap['main']['humidity'] ?? 0;
    this.description = weatherMap['weather'][0]['main'] ?? '';
  }
}
