import 'package:city_temp/blocs/weather_bloc.dart';
import 'package:city_temp/blocs/weather_events.dart';
import 'package:city_temp/blocs/weather_state.dart';
import 'package:city_temp/data/city_weather.dart';
import 'package:city_temp/data/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TempsScreen extends StatelessWidget {
  const TempsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('City Temps')),
      body: WeathersList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          try {
            var cityWeather =
                await Provider.of<WeatherService>(context, listen: false)
                    .getCityWeather('Boston');
            BlocProvider.of<WeatherBloc>(context)
                .add(WeatherAdded(cityWeather));
          } catch (e) {
            // show something
          }
        },
      ),
    );
  }
}

class WeathersList extends StatelessWidget {
  const WeathersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        if (state is WeatherLoadInProgress) {
          return WeatherLoading();
        } else if (state is WeatherLoadSuccess) {
          return WeatherListView(weathers: state.weathers);
        }
        return Text('error');
      }),
    );
  }
}

class WeatherListView extends StatelessWidget {
  final List<CityWeather> weathers;
  WeatherListView({Key? key, required this.weathers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: weathers
          .map((e) => ListTile(
                title: Text(e.city),
              ))
          .toList(),
    );
  }
}

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(48),
            child: CircularProgressIndicator(),
          ),
          Text(
            'Loading Weather',
            style:
                TextStyle(fontSize: 24, color: Theme.of(context).accentColor),
          ),
        ],
      ),
    );
  }
}
