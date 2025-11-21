import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:weather_app/cubits/weather/get_weather_cubit.dart';
import 'package:weather_app/cubits/visibility/visibility_cubit.dart';
import 'package:weather_app/cubits/visibility/visibility_states.dart';
import 'package:weather_app/ui/home/screen/home_screen.dart';
import 'package:weather_app/ui/home/widgets/home_appbar.dart';
import 'package:weather_app/util/easy_bouncing_scroll_physics.dart';

class WeatherCarousel extends StatefulWidget {
  const WeatherCarousel({super.key});

  @override
  State<WeatherCarousel> createState() => _WeatherCarouselState();
}

class _WeatherCarouselState extends State<WeatherCarousel> {
  late LinkedScrollControllerGroup scrollControllerGroup;
  late PageController sharedPageController;
  List<ScrollController> scrollControllerList = [];
  String? cityName;

  @override
  initState() {
    super.initState();
    scrollControllerGroup = LinkedScrollControllerGroup();
    sharedPageController = PageController();

    final cubit = context.read<GetWeatherCubit>();

    createScrollControllers(cubit.searchedCitiesList.length);

    if (cubit.searchedCitiesList.isNotEmpty) {
      final firstCity = cubit.searchedCitiesList[0];
      final isDay = cubit.citiesDataMap[firstCity]!.isDay;
      cubit.updateIndex(0, isDay);
    }
  }

  void createScrollControllers(int cityCount) {
    while (scrollControllerList.length < cityCount) {
      scrollControllerList.add(scrollControllerGroup.addAndGet());
    }
  }

  @override
  void dispose() {
    sharedPageController.dispose();
    for (ScrollController i in scrollControllerList) {
      i.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<GetWeatherCubit>();
    final searchedCities = cubit.searchedCitiesList;
    final citiesData = cubit.citiesDataMap;

    createScrollControllers(searchedCities.length);

    return BlocBuilder<VisibilityCubit, VisibilityState>(
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state is InvisibleState,
          child: AnimatedOpacity(
            opacity: state is VisibleState ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: HomeAppbar(
                title: cityName ?? citiesData[searchedCities[0]]!.cityName,

                smoothPageController: sharedPageController,
              ),
              body: PageView.builder(
                controller: sharedPageController,
                physics: const EasyBouncingScrollPhysics(),
                itemCount: searchedCities.length,
                onPageChanged: (index) {
                  cubit.updateIndex(
                    index,
                    citiesData[searchedCities[index]]!.isDay,
                  );
                  cityName = searchedCities[index];
                },
                itemBuilder: (BuildContext context, int index) {
                  return HomeScreen(
                    scrollController: scrollControllerList[index],
                    index: index,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
