import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CardTemperaturaDashboard extends StatelessWidget {
  final double? value;
  final List<double>? series;

  const CardTemperaturaDashboard({this.value, this.series, super.key});

  bool get hasData => series != null && (series?.isNotEmpty == true);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.thermostat_outlined, size: 28, color: Color(0xFFEF6C00)),
            SizedBox(width: 8),
            Text(
              '${value?.toStringAsFixed(1)}°C',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        if (hasData) ...[
          SizedBox(height: 8),
          Text(
            'Variação nas últimas 24h',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          SizedBox(height: 8),
          TemperatureMiniChart(series: series!),
        ],
      ],
    );
  }
}

class TemperatureMiniChart extends StatelessWidget {
  final List<double> series;

  const TemperatureMiniChart({required this.series, super.key});

  @override
  Widget build(BuildContext context) {
    if (series.isEmpty) {
      return Container();
    }
    final spots = [
      for (int i = 0; i < series.length; i++) FlSpot(i.toDouble(), series[i]),
    ];

    final minY = series.isEmpty ? 0 : series.reduce(min);
    final maxY = series.isEmpty ? 1 : series.reduce(max);

    return SizedBox(
      height: 70,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              barWidth: 2,
              color: Colors.orange,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.orange.withOpacity(0.15),
              ),
            ),
          ],
          minY: minY - 1,
          maxY: maxY + 1,
        ),
      ),
    );
  }
}
