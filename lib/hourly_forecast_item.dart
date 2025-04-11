import 'package:flutter/material.dart';

class HourlyWeatherForecastItem extends StatelessWidget {
  const HourlyWeatherForecastItem({
    super.key,
    required this.time,
    required this.value,
  });

  final String time;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              '12:00',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 10),
            Icon(Icons.cloud, size: 32),
            const SizedBox(height: 10),
            Text('302.17'),
          ],
        ),
      ),
    );
  }
}
