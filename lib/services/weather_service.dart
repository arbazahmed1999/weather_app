import 'package:weather_app/modals/weather_modal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Provides a service to fetch weather data from the OpenWeatherMap API.
class WeatherServices {
  final String apikey = '14f3ab2b33f190188b51819c73ee0427';

// Function to fetch weather data for a given city
  Future<Weather> fetchWeather(String cityName) async {
     // Making an HTTP GET request to fetch weather data
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apikey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
