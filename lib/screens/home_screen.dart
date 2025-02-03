import 'package:flutter/material.dart';
import 'package:weather_app/modals/weather_modal.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/widgets/weather_card.dart';

// Main screen of the app that displays weather information
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Creating an instance of WeatherServices to fetch weather data
  final WeatherServices _weatherServices = WeatherServices();

  // Controller to get input from the user (city name)
  final TextEditingController _controller = TextEditingController();

  // Boolean to track loading state
  bool _isloading = false;

  // Variable to store fetched weather data
  Weather? _weather;

  // Function to fetch weather data based on user input
  void _getWeather() async {
    setState(() {
      _isloading = true; // Show loading indicator while fetching data
    });

    try {
      final weather = await _weatherServices.fetchWeather(_controller.text);
      setState(() {
        _weather = weather; // Update weather data
        _isloading = false; // Hide loading indicator
      });
    } catch (e) {
      // Show an error message if fetching fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching weather data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            // Background gradient changes based on weather condition
            decoration: BoxDecoration(
                gradient: _weather != null &&
                        _weather!.description.toLowerCase().contains('rain')
                    ? const LinearGradient(
                        colors: [Colors.grey, Colors.blueGrey],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)
                    : _weather != null &&
                            _weather!.description
                                .toLowerCase()
                                .contains('clear')
                        ? const LinearGradient(
                            colors: [Colors.orangeAccent, Colors.blueAccent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)
                        : const LinearGradient(
                            colors: [Colors.blue, Colors.lightBlueAccent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    // App title
                    const Text(
                      'Weather App',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 25),
                    // Text field for user to enter city name
                    TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "Enter City Name",
                          hintStyle: const TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Color.fromARGB(110, 255, 255, 255),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none)),
                    ),
                    const SizedBox(height: 20),
                    // Button to fetch weather data
                    ElevatedButton(
                      onPressed: _getWeather,
                      child: Text(
                        'Get Weather',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(209, 244, 244, 244),
                          foregroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                    // Show loading indicator while fetching data
                    if (_isloading)
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    // Show weather details if data is available
                    if (_weather != null) WeatherCard(weather: _weather!),
                  ],
                ),
              ),
            )));
  }
}
