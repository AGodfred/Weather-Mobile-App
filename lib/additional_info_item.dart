import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String value;

  const AdditionalInfoItem({
    super.key,
    // required this.icon,
    required this.icon,
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 40),
        const SizedBox(height: 10),
        Text(text, style: TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ],
    );
  }
}
