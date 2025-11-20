import 'dart:math';

import 'package:flutter/material.dart';
import 'package:plant_health/src/pages/dashboard/widget/card/card_informacoes_dashboard.dart';
import 'package:plant_health/src/pages/dashboard/widget/card/card_luminosidade_dashboard.dart';
import 'package:plant_health/src/pages/dashboard/widget/card/card_temperatura_dashboard.dart';
import 'package:plant_health/src/pages/dashboard/widget/card/card_umidade_ar_dashboard.dart';
import 'package:plant_health/src/pages/dashboard/widget/card/card_umidade_solo_dashboard.dart';
import 'package:plant_health/src/pages/dashboard/widget/grafico_mensal_dashboard.dart';
import 'package:plant_health/src/pages/dashboard/widget/indicador_rapido_dashboard.dart';
import 'package:plant_health/src/shared/constantes.dart';
import 'package:plant_health/src/shared/style/textstyle.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  // Dados de exemplo
  Map<String, dynamic> sampleData() {
    return {
      'temperature': 24.3,
      'airHumidity': 56,
      'soilHumidity': 42,
      'luminosity': 350,
      'lastReading': '11:45 — 16/11/2025',
      'tempSeries': List<double>.generate(
        24,
        (i) => 18 + 6 * sin(i / 3) + Random(i).nextDouble() * 1.2,
      ),
      'monthlySeries': List<double>.generate(
        30,
        (i) => 20 + (i % 7 - 3) * 0.8 + Random(i).nextDouble() * 1.5,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final data = sampleData();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: PlantTextStyle.bodyXL(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CardInformacoes(
                    title: 'Temperatura',
                    color: Colors.white,
                    child: CardTemperaturaDashboard(
                      value: data['temperature'],
                      series: data['tempSeries'],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: CardInformacoes(
                    title: 'Luminosidade',
                    color: Colors.white,
                    child: CardLuminosidade(value: data['luminosity']),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CardInformacoes(
                    title: 'Umidade do Ar',
                    color: Colors.white,
                    child: CardUmidadeArDashboard(value: data['airHumidity']),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CardInformacoes(
                    title: 'Umidade do Solo',
                    color: Colors.white,
                    child: CardUmidadeSolo(value: data['soilHumidity']),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            // Gráfico mensal e KPIs
            CardInformacoes(
              title: 'Tendência Mensal (médias diárias)',
              color: Colors.white,
              child: GraficoMensal(series: data['monthlySeries']),
            ),
            SizedBox(height: 12),
            // Rodapé com indicadores rápidos
            Row(
              children: [
                Expanded(
                  child: IndicadorRapido(
                    label: 'Última leitura',
                    value: data['lastReading'],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: IndicadorRapido(
                    label: 'Status',
                    value: 'OK',
                    statusColor: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 18),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.history),
                  label: Text('Ver histórico'),
                ),
                SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.download_rounded),
                  label: Text('Exportar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
