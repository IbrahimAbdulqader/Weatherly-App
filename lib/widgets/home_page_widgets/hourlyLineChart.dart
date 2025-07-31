import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit.dart';

class HourlyLineChart extends StatelessWidget {
  const HourlyLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    var weatherModel = BlocProvider.of<GetWeatherCubit>(context).weatherModel;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 200,
        width: 1900,
        child: LineChart(
          LineChartData(
            lineTouchData: const LineTouchData(enabled: false),
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              show: true,
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 50,
                  getTitlesWidget:
                      (value, meta) => TopTitleWidget(value: value, meta: meta),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 50,
                  getTitlesWidget:
                      (value, meta) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: BottomTitleWidget(value: value, meta: meta),
                      ),
                ),
              ),
            ),
            minX: 0,
            maxX: 25,
            minY: -20,
            maxY: 50,
            lineBarsData: [
              LineChartBarData(
                spots: [
                  ...List.generate(26, (index) {
                    return FlSpot(
                      index * 1,
                      weatherModel.hourlyTemp[now.hour + index],
                    );
                  }),
                ],
                isCurved: true,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 1],
                  colors: [Colors.deepOrange, Colors.amber],
                ),
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withValues(alpha: 0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

DateTime now = DateTime.now();

class TopTitleWidget extends StatelessWidget {
  const TopTitleWidget({super.key, required this.value, required this.meta});
  final double value;
  final TitleMeta meta;

  @override
  Widget build(BuildContext context) {
    var weatherModel = BlocProvider.of<GetWeatherCubit>(context).weatherModel;

    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.white,
    );

    int index = value.toInt();
    int hourIndex = (now.hour + index);
    if (index == 0 || index == 25) {
      return SideTitleWidget(meta: meta, child: const Text(' ', style: style));
    } else {
      return SideTitleWidget(
        meta: meta,
        child: Text(
          '${weatherModel.hourlyTemp[hourIndex].toString()}°',
          style: style,
        ),
      );
    }
  }
}

class BottomTitleWidget extends StatelessWidget {
  final double value;
  final TitleMeta meta;

  const BottomTitleWidget({super.key, required this.value, required this.meta});

  @override
  Widget build(BuildContext context) {
    var weatherModel = BlocProvider.of<GetWeatherCubit>(context).weatherModel;

    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.white,
    );

    int index = value.toInt();
    int hourIndex = (now.hour + index);

    if (index == 1) {
      return SideTitleWidget(
        meta: meta,
        child: const Text('Now', style: style),
      );
    } else if (index == 0 || index == 25) {
      return SideTitleWidget(meta: meta, child: const Text(' ', style: style));
    } else {
      return SideTitleWidget(
        meta: meta,
        child: Text(
          '${weatherModel.hours[hourIndex].hour.toString()}:00',
          style: style,
        ),
      );
    }
  }
}
