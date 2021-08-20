import 'package:city_temp/blocs/weather_bloc.dart';
import 'package:city_temp/blocs/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TempsScreen extends StatelessWidget {
  const TempsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('City Temps')),
      body: Container(padding: EdgeInsets.all(16), child: WeathersList()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class WeathersList extends StatelessWidget {
  const WeathersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherLoadInProgress) {
        return WeatherLoading();
      } else if (state is WeatherLoadSuccess) {
        return ListView(
          children: state.weathers
              .map((e) => ListTile(
                    title: Text(e.city),
                  ))
              .toList(),
        );
      }
      return Text('error');
    });
  }
}

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Loading Weather...',
        style: TextStyle(fontSize: 24, color: Theme.of(context).accentColor),
      ),
    );
  }
}
