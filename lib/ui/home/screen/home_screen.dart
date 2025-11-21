import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/cubits/weather/get_weather_cubit.dart';
import 'package:weather_app/cubits/weather/get_weather_states.dart';
import 'package:weather_app/ui/home/widgets/hourly_line_chart.dart';
import 'package:weather_app/ui/shared/widgets/scroll_divider.dart';
import 'package:weather_app/ui/home/widgets/aqi_info.dart';
import 'package:weather_app/ui/shared/widgets/blurry_container.dart';
import 'package:weather_app/ui/home/widgets/daily_temp_section.dart';
import 'package:weather_app/ui/home/widgets/hyper_link.dart';
import 'package:weather_app/ui/home/widgets/main_temp_section.dart';
import 'package:weather_app/ui/home/widgets/weather_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.index,
    required this.scrollController,
  });

  final ScrollController scrollController;
  final int index;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(onScroll);
  }

  void onScroll() {
    if (mounted) {
      final double newOpacity = 1 - (widget.scrollController.offset / 125.h);
      context.read<GetWeatherCubit>().updateOpacity(newOpacity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        displacement: 50.h,
        strokeWidth: 3,
        backgroundColor: Colors.transparent,
        color: Colors.white,
        elevation: 0,
        onRefresh: () async {
          context.read<GetWeatherCubit>().updateWeather();
        },
        child: SingleChildScrollView(
          controller: widget.scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 110.h),
              BlocBuilder<GetWeatherCubit, WeatherState>(
                buildWhen:
                    (prev, curr) =>
                        curr is WeatherLoadedState && prev is WeatherLoadedState
                            ? prev.opacity != curr.opacity
                            : true,
                builder: (context, state) {
                  if (state is WeatherLoadedState) {
                    return AnimatedOpacity(
                      opacity: state.opacity,
                      duration: const Duration(milliseconds: 200),
                      child: MainTempWidget(index: widget.index),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              SizedBox(height: 140.h),
              BlurryContainer(
                width: 340.w,
                height: 315.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const ScrollDivider(),
                    Center(
                      child: Text(
                        '3 - Day Forecast',
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                    ),
                    SizedBox(
                      height: 190.h,
                      child: DailyTemp(index: widget.index),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
              BlurryContainer(
                width: 340.w,
                height: 225.h,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.r),
                      child: Text(
                        '24 - Hour Forecast',
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                    ),
                    Expanded(child: HourlyLineChart(index: widget.index)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlurryContainer(
                    width: 165.w,
                    height: 300.h,
                    horizontalPadding: 5.h,
                    child: WeatherInfo(index: widget.index),
                  ),
                  BlurryContainer(
                    width: 165.w,
                    height: 300.h,
                    horizontalPadding: 5.h,
                    child: AqiInfo(index: widget.index),
                  ),
                ],
              ),
              const HyperLink(),
            ],
          ),
        ),
      ),
    );
  }
}
