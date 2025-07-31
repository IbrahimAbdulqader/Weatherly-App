import 'package:flutter/material.dart';
import 'package:weather_app/widgets/home_page_widgets/aqi_info.dart';
import 'package:weather_app/widgets/general_widgets/blurry_container.dart';
import 'package:weather_app/widgets/general_widgets/custom_sliver_appbar.dart';
import 'package:weather_app/widgets/home_page_widgets/daily_temp.dart';
import 'package:weather_app/widgets/home_page_widgets/hyper_link.dart';
import 'package:weather_app/widgets/home_page_widgets/main_temp_widget.dart';
import 'package:weather_app/widgets/home_page_widgets/weather_info.dart';
import '../widgets/general_widgets/custom_scaffold.dart';
import '../widgets/home_page_widgets/hourlyLineChart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/wallpaper.jfif'),
            ),
          ),
        ),
        CustomScaffold(
          slivers: [
            const CustomSliverAppbar(),
            SliverList(
              delegate: SliverChildListDelegate([
                const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 80),
                    MainTempWidget(),
                    SizedBox(height: 150),
                    BlurryContainer(
                      width: 360,
                      height: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Divider(
                            height: 10,
                            color: Colors.white,
                            indent: 110,
                            endIndent: 110,
                          ),
                          Center(
                            child: Text(
                              '3 - Day Forecast',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: 185, child: DailyTemp()),
                        ],
                      ),
                    ),
                    BlurryContainer(
                      width: 360,
                      height: 225,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              '24 - Hour Forecast',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Expanded(child: HourlyLineChart()),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlurryContainer(
                          width: 175,
                          height: 300,
                          horizontalPadding: 5,
                          child: WeatherInfo(),
                        ),
                        BlurryContainer(
                          width: 175,
                          height: 300,
                          horizontalPadding: 5,
                          child: AqiInfo(),
                        ),
                      ],
                    ),
                    HyperLink(),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ],
    );
  }
}
