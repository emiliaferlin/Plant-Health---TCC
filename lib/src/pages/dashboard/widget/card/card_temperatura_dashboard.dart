import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:math';

class CardTemperaturaDashboard extends StatelessWidget {
  final double? value;
  final List<double>? series;
  const CardTemperaturaDashboard({this.value, this.series, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.thermostat_outlined,
                      size: 28,
                      color: Color(0xFFEF6C00),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '${value?.toStringAsFixed(1)}°C',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  'Variação nas últimas 24h',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                SizedBox(height: 8),
                Expanded(child: TemperatureMiniChart(series: series)),
              ],
            ),
          ),
          SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: 50.0,
                lineWidth: 7.0,
                percent: (((value ?? 0) - 10) / 30).clamp(0.0, 1.0),
                center: Text('${value?.toStringAsFixed(0)}°C'),
                progressColor: Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TemperatureMiniChart extends StatelessWidget {
  final List<double>? series;
  const TemperatureMiniChart({this.series, super.key});

  @override
  Widget build(BuildContext context) {
    final spots = <FlSpot>[];
    for (var i = 0; i < (series?.length ?? 0); i++)
      spots.add(FlSpot(i.toDouble(), series![i]));
    final minY = series?.reduce(min);
    final maxY = series?.reduce(max);
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.orange.withOpacity(0.15),
            ),
            color: Colors.orange,
            barWidth: 2,
          ),
        ],
        minY: (minY ?? 0) - 1,
        maxY: (maxY ?? 0) + 1,
      ),
    );
  }
}
