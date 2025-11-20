import 'package:flutter/material.dart';

class CardUmidadeSolo extends StatelessWidget {
  final int? value;
  const CardUmidadeSolo({this.value, super.key});

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
                    const Icon(Icons.grass, color: Color(0xFF6D4C41)),
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
                  'Umidade do solo',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 60,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: 24,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Container(
                  width: 24,
                  height: 70 * pct,
                  decoration: BoxDecoration(
                    color: Colors.green[600],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
