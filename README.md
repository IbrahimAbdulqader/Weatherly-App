# Weatherly-App

Weatherly is a sleek and dynamic weather application built with Flutter. It provides real-time weather information, detailed forecasts, and air quality data in a beautifully designed interface. The app features animated backgrounds that change based on the current weather conditions and time of day, offering an immersive user experience.

## Features

- **Real-time Weather:** Get the current temperature, weather condition, and daily high/low temperatures for any city.
- **Multi-city Management:** Search for, add, and manage a list of up to 10 cities.
- **Detailed Forecasts:**
    - 3-day forecast with daily high/low temperatures and weather conditions.
    - 24-hour hourly forecast presented in an interactive line chart.
- **Air Quality Index (AQI):** View detailed AQI information, including levels of CO, NO2, O3, SO2, PM2.5, and PM10.
- **Dynamic UI:** The app background features looping video animations that correspond to the current weather (e.g., rain, snow, clear skies) and time (day/night).
- **State Management:** Built with `flutter_bloc` for robust and predictable state management.
- **Local Storage:** Saved cities are persisted locally using `Hive` for a seamless experience across app sessions.
- **System Theme:** Automatically adapts to your device's light or dark mode settings.

## Technical Stack

- **Framework:** Flutter
- **State Management:** `flutter_bloc`
- **Networking:** `dio` for handling API requests.
- **Local Storage:** `hive_flutter` for persisting user's city list.
- **UI Components & Animations:**
  - `fl_chart`: For the hourly forecast line chart.
  - `lottie` & `dotlottie_loader`: For weather condition icons.
  - `video_player`: For animated backgrounds.
  - `smooth_page_indicator`: For the city carousel indicator.
  - `flutter_screenutil`: For responsive UI design.
- **API:** [WeatherAPI.com](https://www.weatherapi.com/) for weather data.

## Getting Started

To run this project locally, follow these steps:

### 1. Prerequisites

- Ensure you have Flutter SDK installed on your machine.
- An IDE like VS Code or Android Studio with the Flutter plugin.

### 2. Clone the Repository

```sh
git clone https://github.com/ibrahimabdulqader/weatherly-app.git
cd weatherly-app
```

### 3. Set Up API Key

1.  Sign up on [WeatherAPI.com](https://www.weatherapi.com/) to get a free API key.
2.  In the project, navigate to `lib/consts/api_consts.dart`.
3.  Replace the placeholder API key with your own:

    ```dart
    // lib/consts/api_consts.dart
    const String apiKey = 'YOUR_API_KEY';
    ```

### 4. Install Dependencies

```sh
flutter pub get
```

### 5. Run the Application

```sh
flutter run
```

## Project Structure

The project is structured to separate concerns, making it maintainable and scalable.

```
lib/
├── consts/          # API constants and keys
├── cubits/          # BLoC cubits for state management
├── data/            # Data models and parsers
├── services/        # Services for API calls and local storage (Hive)
├── ui/              # All UI screens and widgets
│   ├── all_cities/
│   ├── aqi/
│   ├── error/
│   ├── home/
│   ├── initial/
│   ├── loading/
│   ├── search/
│   └── shared/
└── util/            # Utility functions, custom widgets, and helpers