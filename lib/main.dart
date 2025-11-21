import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weather_app/cubits/weather/get_weather_states.dart';
import 'package:weather_app/cubits/visibility/visibility_cubit.dart';
import 'package:weather_app/services/hive_services.dart';
import 'package:weather_app/ui/error/screen/error_screen.dart';
import 'package:weather_app/ui/home/screen/weather_carousel.dart';
import 'package:weather_app/ui/initial/screen/initial_city_page.dart';
import 'package:weather_app/ui/loading/screen/loading_screen.dart';
import 'package:weather_app/ui/shared/widgets/background_stack.dart';
import 'package:weather_app/util/color_schemes.dart';
import 'package:weather_app/util/weather_conditions.dart';
import 'cubits/weather/get_weather_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  late final GetWeatherCubit weatherCubit;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    weatherCubit = GetWeatherCubit();
    loadSavedCities();
  }

  Future<void> loadSavedCities() async {
    final savedCities = await HiveServices.hiveGetCitiesNames();

    if (savedCities.isNotEmpty) {
      for (final city in savedCities) {
        await weatherCubit.getWeather(cityName: city);
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    weatherCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 919),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => weatherCubit),
            BlocProvider(create: (context) => VisibilityCubit()),
          ],
          child: MaterialApp(
            theme: ThemeData(
              colorScheme: lightColorScheme,
              textTheme: GoogleFonts.robotoTextTheme().apply(
                bodyColor: lightColorScheme.onPrimary,
                displayColor: lightColorScheme.onPrimary,
              ),
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              colorScheme: darkColorScheme,
              textTheme: GoogleFonts.robotoTextTheme().apply(
                bodyColor: darkColorScheme.onPrimary,
                displayColor: darkColorScheme.onPrimary,
              ),
              brightness: Brightness.dark,
            ),
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
            home:
                isLoading
                    ? const LoadingScreen()
                    : BlocBuilder<GetWeatherCubit, WeatherState>(
                      builder: (context, state) {
                        if (state is WeatherInitialState &&
                            weatherCubit.searchedCitiesList.isEmpty) {
                          return const InitialCityScreen();
                        } else if (state is WeatherLoadingState) {
                          return const LoadingScreen();
                        } else if (state is WeatherLoadedState &&
                            state.searchedCitiesList.isNotEmpty) {
                          return BackgroundStack(
                            index: state.index,
                            videoPath:
                                state
                                            .citiesDataMap[state
                                                .searchedCitiesList[state
                                                .index]]!
                                            .isDay ==
                                        0
                                    ? 'assets/videos/night_${getWeatherAnimationAsset(state.citiesDataMap[state.searchedCitiesList[state.index]]!.weatherCondition)}.mp4'
                                    : 'assets/videos/${getWeatherAnimationAsset(state.citiesDataMap[state.searchedCitiesList[state.index]]!.weatherCondition)}.mp4',
                            child: const WeatherCarousel(),
                          );
                        } else {
                          return const ErrorScreen();
                        }
                      },
                    ),
          ),
        );
      },
    );
  }
}
