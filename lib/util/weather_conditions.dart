String getWeatherAnimationAsset(String condition) {
  condition = condition.toLowerCase().trim();

  switch (condition) {
    case 'sunny':
    case 'clear':
      return "clear";

    case 'partly cloudy':
    case 'cloudy':
    case 'overcast':
      return "broken_clouds";

    case 'mist':
    case 'fog':
      return 'mist';

    case 'light drizzle':
    case 'light rain':
    case 'light rain shower':
    case 'patchy light drizzle':
    case 'patchy rain nearby':
    case 'patchy light rain':
    case 'moderate rain':
    case 'heavy rain':
    case 'torrential rain shower':
      return "rain";

    case 'thundery outbreaks possible':
    case 'moderate or heavy rain with thunder':
      return "thunderstorm";

    case 'freezing fog':
    case 'light snow':
    case 'moderate snow':
    case 'heavy snow':
    case 'blizzard':
      return "snow";

    default:
      return "clear";
  }
}
