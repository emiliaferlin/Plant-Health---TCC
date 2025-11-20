import 'package:flutter/material.dart';
import 'package:plant_health/src/pages/dados_atuais/widget/card_dados_atuais.dart';
import 'package:plant_health/src/shared/constantes.dart';
import 'package:plant_health/src/shared/style/textstyle.dart';

class DadosAtuaisView extends StatelessWidget {
  const DadosAtuaisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dados Atuais",
          style: PlantTextStyle.bodyXL(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Últimas Leituras",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.95,
                children: [
                  CardDadosAtuais(
                    icon: Icons.thermostat,
                    title: "Temperatura",
                    value: "24.3°C",
                    color: Colors.redAccent,
                  ),
                  CardDadosAtuais(
                    icon: Icons.water_drop,
                    title: "Umidade do Ar",
                    value: "56%",
                    color: Colors.blueAccent,
                  ),
                  CardDadosAtuais(
                    icon: Icons.eco,
                    title: "Umidade do Solo",
                    value: "42%",
                    color: Colors.brown,
                  ),
                  CardDadosAtuais(
                    icon: Icons.wb_sunny,
                    title: "Luminosidade",
                    value: "350 lux",
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Última leitura: 16/11/2025 - 11:45",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
