import 'package:dio/dio.dart';

class CitySuggestionsService {
  final Dio dio;
  final String baseUrl = 'https://api.weatherapi.com/v1';
  final String apiKey = '7a826ac52a354785bcf135928250907';

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

      final cityNames = data.map((e) => e['name'] as String).toList();
      final countries = data.map((e) => e['country'] as String).toList();

      return {'names': cityNames, 'countries': countries};
    } catch (e) {
      return {'names': [], 'countries': []};
    }
  }
}
