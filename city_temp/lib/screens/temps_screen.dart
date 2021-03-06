import 'package:city_temp/blocs/weather_bloc.dart';
import 'package:city_temp/blocs/weather_events.dart';
import 'package:city_temp/blocs/weather_state.dart';
import 'package:city_temp/data/prefs.dart';
import 'package:city_temp/widgets/weather_card.dart';
import 'package:city_temp/widgets/weather_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TempsScreen extends StatefulWidget {
  TempsScreen({Key? key}) : super(key: key);

  @override
  _TempsScreenState createState() => _TempsScreenState();
}

class _TempsScreenState extends State<TempsScreen> {
  final txtCityName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('City Temps')),
      body: _weathersList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showAddCityDialog(context);
        },
      ),
    );
  }

  Widget _weathersList() {
    return Container(
      padding: EdgeInsets.all(8),
      child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        if (state is LoadCitiesInProgress) {
          return WeatherLoading(context: context);
        } else if (state is LoadCitiesSuccess) {
          return _weatherListView(context, state.cityNames);
        }
        return Text('error');
      }),
    );
  }

  Widget _weatherListView(BuildContext context, List<String> cityNames) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: cityNames
          .map(
            (cityName) => Dismissible(
              direction: DismissDirection.vertical,
              key: UniqueKey(),
              child: WeatherCard(cityName: cityName),
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

  Future<dynamic> showAddCityDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter a city name'),
            content: SingleChildScrollView(
              child: TextField(
                autofocus: true,
                controller: txtCityName,
                decoration: InputDecoration(hintText: 'City Name'),
              ),
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                  txtCityName.text = '';
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    try {
                      var cityName = txtCityName.text;
                      Provider.of<Prefs>(context, listen: false)
                          .addCity(cityName);
                      BlocProvider.of<WeatherBloc>(context)
                          .add(CityAdded(cityName: cityName));
                    } catch (e) {
                      // show something
                    } finally {
                      txtCityName.text = '';
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add City'))
            ],
          );
        });
  }
}
