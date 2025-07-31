import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit.dart';
import 'package:weather_app/widgets/general_widgets/text_cell.dart';
import '../general_widgets/custom_text_widget.dart';

class AqiDialog extends StatelessWidget {
  const AqiDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var weatherModel = BlocProvider.of<GetWeatherCubit>(context).weatherModel;

    final List<List<String>> aqiRows = [
      ['1', '0–50', 'Good'],
      ['2', '51–100', 'Moderate'],
      ['3', '101–150', 'Sensitive Risk'],
      ['4', '151–200', 'Unhealthy'],
      ['5', '201–300', 'Very Unhealthy'],
      ['6', '300+', 'Hazardous'],
    ];

    final List<Color> aqiColors = [
      Colors.green,
      Colors.yellowAccent,
      Colors.orange,
      Colors.red,
      Colors.brown,
      Colors.purple,
    ];

    return Dialog.fullscreen(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CustomTextWidget(
                text: 'Air Quality Index',
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            const CustomTextWidget(
              text: 'Current AQI:',
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            Text(
              weatherModel.airQualityModel.simplifiedAqi.toString(),
              style: const TextStyle(fontSize: 86, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 35),
            const Row(
              spacing: 50,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextWidget(
                  text: 'Simple AQI',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40),
                  child: CustomTextWidget(
                    text: 'AQI',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomTextWidget(
                  text: 'Level',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            const Divider(color: Colors.white12),
            ...List.generate(aqiRows.length, (index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextCell(text: aqiRows[index][0], isTitle: true),
                      ),
                      Expanded(
                        child: TextCell(text: aqiRows[index][1], isTitle: true),
                      ),
                      Expanded(
                        child: TextCell(
                          text: aqiRows[index][2],

                          color: aqiColors[index],
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white12),
                ],
              );
            }),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const CustomTextWidget(
                  text: 'Back',
                  fontSize: 18,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
