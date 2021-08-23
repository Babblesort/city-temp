import 'package:city_temp/blocs/weather_events.dart';
import 'package:city_temp/blocs/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(LoadCitiesInProgress());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is CitiesLoaded) {
      yield* _mapCitiesLoadedToState(event);
    } else if (event is CityAdded) {
      yield* _mapCityAddedToState(event);
    } else if (event is CityRemoved) {
      yield* _mapCityRemovedToState(event);
    }
  }

  Stream<WeatherState> _mapCitiesLoadedToState(CitiesLoaded event) async* {
    yield LoadCitiesSuccess(cityNames: event.cityNames);
  }

  Stream<WeatherState> _mapCityAddedToState(CityAdded event) async* {
    if (state is LoadCitiesSuccess) {
      var currentCities = (state as LoadCitiesSuccess).cityNames;
      var updatedCities = [...currentCities, event.cityName];
      yield LoadCitiesSuccess(cityNames: updatedCities);
    }
  }

  Stream<WeatherState> _mapCityRemovedToState(CityRemoved event) async* {
    if (state is LoadCitiesSuccess) {
      final List<String> cities = List.from(
          (state as LoadCitiesSuccess).cityNames
            ..retainWhere((cityName) => cityName != event.cityName));

      yield LoadCitiesSuccess(cityNames: cities);
    }
  }
}
