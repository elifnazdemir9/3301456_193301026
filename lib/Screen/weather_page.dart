import 'package:flutter/material.dart';
import 'package:mobil/Services/api_service.dart';
class WeatherPage extends StatelessWidget {
  WeatherData? weatherData;
  String locationName;
   WeatherPage({Key? key,required this.weatherData,required this.locationName}) : super(key: key);
  String determineTemperatureCondition() {
    double temperature = weatherData?.currentWeather.temperature ?? 0.0;

    if (temperature > 30) {
      return 'Hot';
    } else if (temperature < 10) {
      return 'Cold';
    } else {
      return 'Moderate';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.deepPurpleAccent],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(this.locationName,style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
              ),
              Icon(
                Icons.cloud,
                size: 80,
                color: Colors.white,
              ),
              SizedBox(height: 16),
              Text(
                determineTemperatureCondition(),
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Temperature: ${this.weatherData!.currentWeather.temperature}°C',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Wind:  ${this.weatherData!.currentWeather.windSpeed} km/hr',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'wind direction:${this.weatherData!.currentWeather.windDirection}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ) ,
    );
  }
}
