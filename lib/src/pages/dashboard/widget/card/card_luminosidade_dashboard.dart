import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CardLuminosidade extends StatelessWidget {
  final double? value;
  const CardLuminosidade({this.value, super.key});

  @override
  Widget build(BuildContext context) {
    final pct = ((value ?? 0) / 1000).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.wb_sunny_outlined, size: 26, color: Color(0xFFFFB300)),
            SizedBox(width: 8),
            Text(
              '$value lux',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Níveis de luminosidade',
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
        SizedBox(height: 16),
        LinearPercentIndicator(
          lineHeight: 16.0,
          percent: pct,
          center: Text('${(pct * 100).round()}%'),
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: Colors.amber,
          backgroundColor: Colors.grey[200],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Baixo', style: TextStyle(fontSize: 12)),
            Text('Alto', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }
}
