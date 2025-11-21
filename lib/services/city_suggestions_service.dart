import 'package:dio/dio.dart';
import 'package:weather_app/consts/api_consts.dart';

class CitySuggestionsService {
  final Dio dio;

  CitySuggestionsService(this.dio);

  Future<Map<String, List<String>>> getNameAndCountrySuggestions(
    String cityName,
  ) async {
    if (cityName.length < 2) return {'names': [], 'countries': []};

    try {
      final response = await dio.get(
        '$baseUrl/search.json?key=$apiKey&q=$cityName',
      );

      final List data = response.data;

      final filteredData = data.where(
        (e) => !(e['name'] as String).toLowerCase().contains('airport'),
      );

      final cityNames = filteredData.map((e) => e['name'] as String).toList();
      final countries =
          filteredData.map((e) => e['country'] as String).toList();

      return {'names': cityNames, 'countries': countries};
    } catch (e) {
      return {'names': [], 'countries': []};
    }
  }
}
