import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../cubits/get_weather_cubit.dart';

class MainTempWidget extends StatelessWidget {
  const MainTempWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var weatherModel = BlocProvider.of<GetWeatherCubit>(context).weatherModel;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: GradientText(
                weatherModel.currentTemp.round().toString(),
                style: const TextStyle(
                  fontSize: 124,
                  fontWeight: FontWeight.w600,
                ),
                gradientDirection: GradientDirection.ttb,
                stops: const [0, .5, .75],
                colors: [Colors.white, Colors.white, Colors.white.withAlpha(0)],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 55),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 44,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: '°',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 50,
                      ),
                    ),
                    TextSpan(text: 'c'),
                  ],
                ),
              ),
            ),
          ],
        ),
        RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
            children: [
              TextSpan(text: '${weatherModel.maxTemp.round().toString()}°'),
              const TextSpan(
                text: '/',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              TextSpan(text: '${weatherModel.minTemp.round().toString()}°'),
            ],
          ),
        ),
        Text(
          weatherModel.weatherCondition,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 32,
          ),
        ),
      ],
    );
  }
}
