import 'package:city_temp/data/temps_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TempsScreen extends StatelessWidget {
  const TempsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var addCityHandler =
        Provider.of<TempsState>(context, listen: false).addCity;

    return Scaffold(
      appBar: AppBar(title: Text('City Temps')),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Consumer<TempsState>(
          builder: (context, temps, child) {
            return ListView(
              children: temps.cityWeathers
                  .map((e) => ListTile(title: Text(e.city)))
                  .toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addCityHandler('new city');
        },
      ),
    );
  }
}
