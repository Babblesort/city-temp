import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences prefs;
  static const String CITIES_KEY = 'cities';

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future writeCities(List<String> cityNames) async {
    prefs.setStringList(CITIES_KEY, cityNames);
  }

  List<String> getCities() {
    return prefs.getStringList(CITIES_KEY) ?? [];
  }

  Future addCity(String cityName) async {
    var cities = getCities();

    if (!cities.any((city) => city == cityName)) {
      cities.add(cityName);
      await writeCities(cities);
    }
  }

  Future removeCity(String cityName) async {
    var cities = getCities();
    cities.retainWhere((city) => city != cityName);
    await writeCities(cities);
  }

  Future deleteSession(int id) async {
    prefs.remove(id.toString());
  }
}
