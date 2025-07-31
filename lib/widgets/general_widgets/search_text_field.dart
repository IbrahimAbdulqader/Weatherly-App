import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/get_weather_cubit.dart';
import '../../services/city_suggestions_service.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _controller = TextEditingController();
  final CitySuggestionsService suggestionsService = CitySuggestionsService(
    Dio(),
  );
  List<String> suggestionsName = [];
  List<String> suggestionsCountry = [];

  void onCitySelected(String city) {
    _controller.text = city;
    setState(() => suggestionsName = []);
    setState(() => suggestionsName = []);
    final getWeatherCubit = BlocProvider.of<GetWeatherCubit>(context);
    getWeatherCubit.getWeather(cityName: city);
    // You can also navigate away if needed
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        const SizedBox(height: 120),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            cursorColor: isDark ? Colors.white : Colors.black,

            onChanged: (value) async {
              final result = await suggestionsService
                  .getNameAndCountrySuggestions(value);
              setState(() => suggestionsName = result['names']!);
              setState(() => suggestionsCountry = result['countries']!);
            },
            decoration: InputDecoration(
              labelText: 'Search',
              labelStyle: TextStyle(
                color: isDark ? Colors.white : Colors.black,
              ),
              suffixIcon: const Icon(Icons.search),
              hintText: 'City Name',
              // hintStyle: const TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: isDark ? Colors.white : Colors.black,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: isDark ? Colors.white : Colors.black,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
        if (suggestionsName.isNotEmpty)
          SizedBox(
            height: 500,
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 35),
              separatorBuilder: (BuildContext context, index) {
                return const Divider(height: 3, indent: 45, endIndent: 45);
              },
              itemCount: suggestionsName.length,
              itemBuilder: (context, index) {
                final city = suggestionsName[index];
                final country = suggestionsCountry[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListTile(
                    title: Text(city),
                    onTap: () => onCitySelected(city),
                    subtitle: Text(country),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
