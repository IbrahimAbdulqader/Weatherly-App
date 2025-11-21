import 'package:hive/hive.dart';

class HiveServices {
  static String boxName = 'citiesBox';
  static String citiesKey = 'citiesNames';
  static List<String> citiesList = [];

  static Future<void> hiveSaveCityName(String cityName) async {
    final hiveBox = await Hive.openBox(boxName);

    citiesList = List<String>.from(hiveBox.get(citiesKey, defaultValue: []));

    if (!citiesList.contains(cityName)) {
      citiesList.add(cityName);
      hiveBox.put(citiesKey, citiesList);
    }
  }

  static Future<List<String>> hiveGetCitiesNames() async {
    final hiveBox = await Hive.openBox(boxName);

    final List<String> savedCities = List<String>.from(
      hiveBox.get(citiesKey, defaultValue: []),
    );
    citiesList = savedCities;
    return savedCities;
  }

  static Future<void> hiveDeleteCityName(String name) async {
    final hiveBox = await Hive.openBox(boxName);
    citiesList = List<String>.from(hiveBox.get(citiesKey, defaultValue: []));
    citiesList.remove(name);
    hiveBox.put(citiesKey, citiesList);
  }
}
