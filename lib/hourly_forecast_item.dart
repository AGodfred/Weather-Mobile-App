import 'package:flutter/material.dart';

class HourlyWeatherForecastItem extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temperature;

  const HourlyWeatherForecastItem({
    super.key,
    required this.time,
    required this.icon,
    required this.temperature,
  });

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
              time,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 10),
            Icon(icon, size: 32),
            const SizedBox(height: 10),
            Text(temperature),
          ],
        ),
      ),
    );
  }
}
