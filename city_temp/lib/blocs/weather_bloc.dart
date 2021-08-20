import 'package:city_temp/blocs/weather_events.dart';
import 'package:city_temp/blocs/weather_state.dart';
import 'package:city_temp/data/city_weather.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherLoadInProgress());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherLoaded) {
      yield* _mapWeatherLoadedToState();
    } else if (event is WeatherAdded) {
      yield* _mapWeatherAddedToState(event);
    }
  }

  Stream<WeatherState> _mapWeatherLoadedToState() async* {
    try {
      final weathers = await _fakeLoadWeathers();
      yield WeatherLoadSuccess(weathers: weathers);
    } catch (_) {
      yield WeatherLoadFailure();
    }
  }

  Stream<WeatherState> _mapWeatherAddedToState(WeatherAdded event) async* {
    if (state is WeatherLoadSuccess) {
      final List<CityWeather> updatedWeathers =
          List.from((state as WeatherLoadSuccess).weathers)..add(event.weather);
      yield WeatherLoadSuccess(weathers: updatedWeathers);
    }
  }

  Future<List<CityWeather>> _fakeLoadWeathers() async {
    return Future.delayed(Duration(milliseconds: 2000)).then((onValue) => [
          CityWeather(city: 'Chicago'),
          CityWeather(city: 'Atlanta'),
          CityWeather(city: 'Denver')
        ]);
  }
}
