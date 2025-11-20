import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CardUmidadeArDashboard extends StatelessWidget {
  final int? value;
  const CardUmidadeArDashboard({this.value, super.key});

  @override
  Widget build(BuildContext context) {
    final pct = ((value ?? 0) / 100).clamp(0.0, 1.0);
    return SizedBox(
      height: 110,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.opacity, color: Color(0xFF42A5F5)),
                    const SizedBox(width: 8),
                    Text(
                      '$value%',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Umidade relativa do ar',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          CircularPercentIndicator(
            radius: 40.0,
            lineWidth: 6.0,
            percent: pct,
            center: Text('$value%'),
            progressColor: Colors.blue,
            backgroundColor: Colors.grey[200]!,
          ),
        ],
      ),
    );
  }
}
