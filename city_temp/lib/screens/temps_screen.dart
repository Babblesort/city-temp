import 'package:city_temp/blocs/weather_bloc.dart';
import 'package:city_temp/blocs/weather_events.dart';
import 'package:city_temp/blocs/weather_state.dart';
import 'package:city_temp/data/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TempsScreen extends StatelessWidget {
  TempsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('City Temps')),
      body: WeathersList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          try {
            final cityName = 'Boston';
            Provider.of<Prefs>(context, listen: false).addCity(cityName);
            BlocProvider.of<WeatherBloc>(context)
                .add(CityAdded(cityName: cityName));
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
        if (state is LoadCitiesInProgress) {
          return WeatherLoading();
        } else if (state is LoadCitiesSuccess) {
          return WeatherListView(cityNames: state.cityNames);
        }
        return Text('error');
      }),
    );
  }
}

class WeatherListView extends StatelessWidget {
  final List<String> cityNames;
  WeatherListView({Key? key, required this.cityNames}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: cityNames
          .map(
            (cityName) => Dismissible(
              key: UniqueKey(),
              child: ListTile(title: Text(cityName)),
              onDismissed: (_) async {
                Provider.of<Prefs>(context, listen: false).removeCity(cityName);
                BlocProvider.of<WeatherBloc>(context)
                    .add(CityRemoved(cityName: cityName));
              },
            ),
          )
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
