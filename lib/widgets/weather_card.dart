import 'package:flutter/material.dart';
import 'package:weather_app/modals/weather_modal.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  // Constructor to initialize the WeatherCard with weather data
  const WeatherCard({super.key, required this.weather});

  // Function to format timestamp into human-readable time (hh:mm AM/PM)
  String formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main weather card container
        Container(
          margin: EdgeInsets.all(16), 
          padding: EdgeInsets.all(16), 
          decoration: BoxDecoration(
            color: Color.fromARGB(
                113, 255, 255, 255), 
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Display weather animation based on weather description
              Lottie.asset(
                weather.description.contains('rain')
                    ? 'assets/rain.json' 
                    : weather.description.contains('clear')
                        ? 'assets/sunny.json'
                        : 'assets/cloudy.json', 
                height: 150,
                width: 150,
              ),

              // Display city name
              Text(
                weather.cityName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 10),

              // Display temperature
              Text(
                '${weather.temperature.toStringAsFixed(1)}°C', // Format temperature to 1 decimal place
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              // Display weather description
              Text(
                weather.description,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 20),

              // Display humidity and wind speed
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Humidity: ${weather.humidity}%', // Display humidity percentage
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Wind: ${weather.windSpeed} m/s', // Display wind speed in meters per second
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Display sunrise and sunset times
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.wb_sunny_outlined,
                          color: Colors.orange), 
                      Text(
                        'Sunrise',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        formatTime(weather.sunrise), 
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.nights_stay_outlined,
                          color: Colors.purple), 
                      Text(
                        'Sunset',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        formatTime(weather.sunset),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
