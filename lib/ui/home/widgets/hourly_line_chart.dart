import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../cubits/weather/get_weather_cubit.dart';

class HourlyLineChart extends StatelessWidget {
  const HourlyLineChart({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    var searchedCities =
        BlocProvider.of<GetWeatherCubit>(context).searchedCitiesList;
    var citiesData = BlocProvider.of<GetWeatherCubit>(context).citiesDataMap;
    var currentCityData = citiesData[searchedCities[index]];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 200.h,
        width: 1900.w,
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
                      (value, meta) => TopTitleWidget(
                        value: value,
                        meta: meta,
                        currentIndex: index,
                      ),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 50,
                  getTitlesWidget:
                      (value, meta) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        child: BottomTitleWidget(
                          value: value,
                          meta: meta,
                          currentIndex: index,
                        ),
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
                      currentCityData!.hourlyTemp[now.hour + index],
                    );
                  }),
                ],
                isCurved: true,
                curveSmoothness: 0.15,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 1],
                  colors: [Colors.deepOrange, Colors.amber],
                ),
                barWidth: 3.w,
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
  const TopTitleWidget({
    super.key,
    required this.value,
    required this.meta,
    required this.currentIndex,
  });
  final double value;
  final TitleMeta meta;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    var searchedCities =
        BlocProvider.of<GetWeatherCubit>(context).searchedCitiesList;
    var citiesData = BlocProvider.of<GetWeatherCubit>(context).citiesDataMap;
    var currentCityData = citiesData[searchedCities[currentIndex]];

    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.sp,
      color: Colors.white,
    );

    int index = value.toInt();
    int hourIndex = (now.hour + index);
    if (index == 0 || index == 25) {
      return SideTitleWidget(meta: meta, child: Text(' ', style: style));
    } else {
      return SideTitleWidget(
        meta: meta,
        child: Text(
          '${currentCityData!.hourlyTemp[hourIndex].toString()}°',
          style: style,
        ),
      );
    }
  }
}

class BottomTitleWidget extends StatelessWidget {
  const BottomTitleWidget({
    super.key,
    required this.value,
    required this.meta,
    required this.currentIndex,
  });
  final double value;
  final TitleMeta meta;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    var searchedCities =
        BlocProvider.of<GetWeatherCubit>(context).searchedCitiesList;
    var citiesData = BlocProvider.of<GetWeatherCubit>(context).citiesDataMap;
    var currentCityData = citiesData[searchedCities[currentIndex]];

    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.sp,
      color: Colors.white,
    );

    int index = value.toInt();
    int hourIndex = (now.hour + index);

    if (index == 1) {
      return SideTitleWidget(meta: meta, child: Text('Now', style: style));
    } else if (index == 0 || index == 25) {
      return SideTitleWidget(meta: meta, child: Text(' ', style: style));
    } else {
      return SideTitleWidget(
        meta: meta,
        child: Text(
          '${currentCityData!.hours[hourIndex].hour.toString()}:00',
          style: style,
        ),
      );
    }
  }
}
