import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit.dart';
import '../../pages/search_page.dart';

class CustomSliverAppbar extends StatelessWidget {
  const CustomSliverAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    var weatherModel = BlocProvider.of<GetWeatherCubit>(context).weatherModel;
    return SliverAppBar(
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const SearchPage();
                },
              ),
            );
          },
          icon: const Padding(
            padding: EdgeInsets.only(top: 15, right: 10),
            child: Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ),
      ],
      expandedHeight: 0,
      forceMaterialTransparency: true,
      surfaceTintColor: Colors.transparent,
      snap: false,
      floating: true,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          weatherModel.cityName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
