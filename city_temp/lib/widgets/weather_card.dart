import 'package:city_temp/data/city_weather.dart';
import 'package:city_temp/data/weather_service.dart';
import 'package:city_temp/widgets/weather_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeatherCard extends StatelessWidget {
  final String cityName;
  const WeatherCard({Key? key, required this.cityName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<WeatherService>(context).getCityWeather(cityName),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          CityWeather weather = snapshot.data;
          return SizedBox(
            width: MediaQuery.of(context).size.width - 50,
            height: 300,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          weather.city,
                          style: TextStyle(
                              fontSize: 32,
                              color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          '${weather.temperature.toStringAsFixed(0)}\u00B0',
                          style: TextStyle(
                              fontSize: 38,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weather.description,
                          style: TextStyle(
                              fontSize: 26,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: WeatherLoading(context: context),
            ),
          ),
        );
      },
    );
  }
}
