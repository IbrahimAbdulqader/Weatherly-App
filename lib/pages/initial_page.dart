import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../cubits/get_weather_cubit.dart';
import '../cubits/get_weather_states.dart';
import 'home_page.dart';
import 'landing_page.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetWeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherInitialState) {
          return const InitialSearchPage();
        } else if (state is WeatherLoadedState) {
          return const HomePage();
        } else {
          return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: GradientText(
                'There Was An Error',
                style: const TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.bold,
                ),
                gradientDirection: GradientDirection.ttb,
                stops: const [0, .5, .75],
                colors: [Colors.white, Colors.white, Colors.white.withAlpha(0)],
              ),
            ),
          );
        }
      },
    );
  }
}
