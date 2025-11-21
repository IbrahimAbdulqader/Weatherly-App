import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/cubits/weather/get_weather_cubit.dart';
import 'package:weather_app/cubits/weather/get_weather_states.dart';
import 'package:weather_app/cubits/visibility/visibility_cubit.dart';
import 'package:weather_app/ui/error/screen/error_screen.dart';
import 'package:weather_app/ui/loading/screen/loading_screen.dart';
import 'package:weather_app/ui/all_cities/widgets/city_tile.dart';

class AllCitiesScreen extends StatefulWidget {
  const AllCitiesScreen({super.key});

  @override
  State<AllCitiesScreen> createState() => _AllCitiesScreenState();
}

class _AllCitiesScreenState extends State<AllCitiesScreen> {
  @override
  Widget build(BuildContext context) {
    var searchedCities =
        BlocProvider.of<GetWeatherCubit>(context).searchedCitiesList;
    var citiesData = BlocProvider.of<GetWeatherCubit>(context).citiesDataMap;
    return BlocBuilder<GetWeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoadedState) {
          searchedCities = state.searchedCitiesList;
          citiesData = state.citiesDataMap;

          return PopScope(
            canPop: true,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) {
                context.read<VisibilityCubit>().show();
              }
            },
            child: Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                forceMaterialTransparency: true,
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.read<VisibilityCubit>().show();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                title: Text(
                  'All Cities',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              body: Column(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(height: 120.h),
                          SizedBox(
                            height: 790.h,
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                var currentCityData =
                                    citiesData[searchedCities[index]];
                                return CityTile(
                                  cityName: currentCityData!.cityName,
                                  minTemp:
                                      '${currentCityData.minTemp.round().toString()}°',
                                  maxTemp:
                                      '${currentCityData.maxTemp.round().toString()}°',
                                  currentTemp:
                                      currentCityData.currentTemp
                                          .round()
                                          .toString(),
                                  condition: currentCityData.weatherCondition,
                                  isNight: currentCityData.isDay == 0,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 15.h);
                              },
                              itemCount: searchedCities.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is WeatherLoadingState) {
          return const LoadingScreen();
        } else {
          return const ErrorScreen();
        }
      },
    );
  }
}
