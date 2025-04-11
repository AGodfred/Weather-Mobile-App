import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forecast_item.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
      body: Padding(
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
                            '300.57 °F',
                            style: TextStyle(
                              fontSize: 37,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Icon(Icons.cloud, size: 60),
                          const SizedBox(height: 15),
                          Text('Rain', style: TextStyle(fontSize: 20)),
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
                  HourlyWeatherForecastItem(time: '12:00', value: '301.17',),
                  HourlyWeatherForecastItem(time: '12:00', value: '301.17',),
                  HourlyWeatherForecastItem(time: '12:00', value: '301.17',),
                  HourlyWeatherForecastItem(time: '12:00', value: '301.17',),
                  HourlyWeatherForecastItem(time: '12:00', value: '301.17',),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AdditionalInfoItem(text: 'Humidity', value: '94'),
                AdditionalInfoItem(text: 'Wind Speed', value: '7.64'),
                AdditionalInfoItem(text: 'Pressure', value: '1006'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



