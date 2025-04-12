import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // Global Variables

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final String cityName = 'Ghana, Kumasi';

      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$weatherApiKey',
        ),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              print('refesh');
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),

      // Body
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator.adaptive(),
                  const SizedBox(height: 20),
                  Text('Loading...'),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;

          final currentWeatherData = data['list'][0];

          final currentWeatherTemp = currentWeatherData['main']['temp'];
          final currentWeatherCondition =
              currentWeatherData['weather'][0]['main'];
          final currentWeatherPressure = currentWeatherData['main']['pressure'];
          final currentWeatherHumidity = currentWeatherData['main']['humidity'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];

          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentWeatherTemp °K',
                                style: TextStyle(
                                  fontSize: 37,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Icon(
                                (currentWeatherCondition == 'Clouds' ||
                                        currentWeatherCondition == 'Rain')
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 60,
                              ),
                              const SizedBox(height: 15),
                              Text(
                                '$currentWeatherCondition',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Weather Information
                Text(
                  'Weather Forecast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HourlyWeatherForecastItem(
                        time: '00:00',
                        icon: Icons.cloud,
                        temperature: '301.17',
                      ),
                      HourlyWeatherForecastItem(
                        time: '03:00',
                        icon: Icons.sunny,
                        temperature: '301.17',
                      ),
                      HourlyWeatherForecastItem(
                        time: '06:00',
                        icon: Icons.cloud,
                        temperature: '301.17',
                      ),
                      HourlyWeatherForecastItem(
                        time: '09:00',
                        icon: Icons.foggy,
                        temperature: '301.17',
                      ),
                      HourlyWeatherForecastItem(
                        time: '12:00',
                        icon: Icons.cloud,
                        temperature: '301.17',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
                // Additional Information
                Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      text: 'Humidity',
                      value: currentWeatherHumidity.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air,
                      text: 'Wind Speed',
                      value: currentWindSpeed.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.beach_access,
                      text: 'Pressure',
                      value: currentWeatherPressure.toString(),	
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
