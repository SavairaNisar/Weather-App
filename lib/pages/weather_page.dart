import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models.weather_model.dart';
import '../services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService('9aedb840aeb0e94fa1715c5dc267faf1');
  Weather? _weather;

// fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();
    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    // any errors
    catch (e) {
      print(e);
    }
  }

// weather animations
String getWeatherAnimation(String? mainCondition){
    if(mainCondition==null)
      return'asset/sunny.json';
    switch (mainCondition.toLowerCase()){
      case 'clouds':
        return'asset/cloudy.json';
      case 'mist':
      case 'smoke':
      case 'dust':
      case 'haze':
      case 'fog':
      return'asset/cloudy.json';
      case 'rain':
        return'asset/rain.json';
      case' drizzle':
        return'asset/rain.json';
      case 'shower rain':
        return'asset/rain.json';
      case 'thunderstorm':
      return'asset/thunder.json';
      case 'clear':
        return'asset/sunny.json';
      default:
        return'asset/sunny.json';
    }
}
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityName ?? "Loading city..",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            SizedBox(height: 40),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            SizedBox(height: 40),
            Text(
              '${_weather?.tempreature.round()}°C',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(49, 49, 49, 100)),
            ),
            Text(
              _weather?.mainCondition ?? "",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(49, 49, 49, 100)),

            ),
          ],
        ),
      ),
    );
  }
}
