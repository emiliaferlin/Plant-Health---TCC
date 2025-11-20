import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class GraficoMensal extends StatelessWidget {
  final List<double>? series;
  const GraficoMensal({this.series, super.key});

  @override
  Widget build(BuildContext context) {
    final spots = <FlSpot>[];
    for (var i = 0; i < (series?.length ?? 0); i++) {
      spots.add(FlSpot(i.toDouble(), series![i]));
    }
    final minY = series?.reduce(min);
    final maxY = series?.reduce(max);
    return SizedBox(
      height: 180,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true, horizontalInterval: 2),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                interval: 5,
                getTitlesWidget: (v, meta) {
                  return Text(
                    '${v.toInt() + 1}',
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, interval: 2),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              barWidth: 2.5,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.green.withOpacity(0.12),
              ),
              color: Colors.green,
            ),
          ],
          minY: (minY ?? 0) - 2,
          maxY: (maxY ?? 0) + 2,
        ),
      ),
    );
  }
}
