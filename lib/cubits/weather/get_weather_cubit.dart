import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/services/hive_services.dart';
import 'package:weather_app/services/weather_service.dart';
import 'get_weather_states.dart';

class GetWeatherCubit extends Cubit<WeatherState> {
  GetWeatherCubit() : super(WeatherInitialState());

  final weatherServices = WeatherService(Dio());
  List searchedCitiesList = [];
  Map<String, WeatherModel?> citiesDataMap = {};
  int currentIndex = 0;
  double opacity = 1;

  updateIndex(int index, int currentIsDay) {
    currentIndex = index;
    if (currentIndex > searchedCitiesList.length - 1) {
      currentIndex = searchedCitiesList.length - 1;
    }
    emitLoadedState();
  }

  updateOpacity(double newOpacity) {
    opacity = newOpacity.clamp(0, 1);
    emitLoadedState();
  }

  deleteACity({required String cityName}) async {
    await HiveServices.hiveDeleteCityName(cityName);
    searchedCitiesList.remove(cityName);
    citiesDataMap.remove(cityName);
    //await Future.delayed(const Duration(milliseconds: 200));
    emitLoadedState();
  }

  Future<void> loadSavedCities() async {
    searchedCitiesList = await HiveServices.hiveGetCitiesNames();

    for (final city in searchedCitiesList) {
      final weatherData = await weatherServices.getCurrentWeather(
        cityName: city,
      );
      citiesDataMap[city] = weatherData;
    }

    emitLoadedState();
  }

  getWeather({required String cityName, int currentIsDay = 1}) async {
    try {
      emit(WeatherLoadingState());

      final weatherData = await weatherServices.getCurrentWeather(
        cityName: cityName,
      );
      citiesDataMap[cityName] = weatherData;

      if (searchedCitiesList.contains(cityName)) {
        searchedCitiesList.remove(cityName);
      }
      searchedCitiesList.insert(0, cityName);

      if (currentIndex > searchedCitiesList.length - 1) {
        currentIndex = searchedCitiesList.length - 1;
      }

      await HiveServices.hiveSaveCityName(cityName);

      emitLoadedState();
    } catch (e) {
      emit(WeatherFailureState(e.toString()));
    }
  }

  updateWeather() async {
    try {
      for (final cityName in searchedCitiesList) {
        final data = await weatherServices.getCurrentWeather(
          cityName: cityName,
        );
        citiesDataMap[cityName] = data;
      }
      emitLoadedState();
    } catch (e) {
      emit(WeatherFailureState(e.toString()));
    }
  }

  void emitLoadedState() {
    emit(
      WeatherLoadedState(
        searchedCitiesList: searchedCitiesList,
        citiesDataMap: citiesDataMap,
        index: currentIndex,
        opacity: opacity,
      ),
    );
  }
}
