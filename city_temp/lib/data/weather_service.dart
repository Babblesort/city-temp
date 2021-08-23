import 'package:city_temp/data/city_weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  final String _authority = 'api.openweathermap.org';
  final String _path = 'data/2.5/weather';
  final String _apiKey = dotenv.env['API_KEY'] ?? '';

  Future<CityWeather> getCityWeather(String city) async {
    Map<String, dynamic> parameters = {'q': city, 'appId': _apiKey};
    Uri uri = Uri.https(_authority, _path, parameters);
    http.Response result = await http.get(uri);
    Map<String, dynamic> data = json.decode(result.body);

    CityWeather weather = CityWeather.fromJson(data);
    return weather;
  }
}
