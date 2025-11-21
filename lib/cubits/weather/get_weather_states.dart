import 'package:weather_app/data/models/weather_model.dart';

class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final List searchedCitiesList;
  final Map<String, WeatherModel?> citiesDataMap;
  final int index;
  final double opacity;

  WeatherLoadedState({
    required this.searchedCitiesList,
    required this.citiesDataMap,
    required this.index,
    required this.opacity,
  });
}

class WeatherFailureState extends WeatherState {
  final String errorMessage;

  WeatherFailureState(this.errorMessage);
}
