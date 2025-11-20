import 'package:flutter/material.dart';
import 'package:plant_health/src/pages/dados_atuais/widget/card_dados_atuais.dart';

class DadosAtuaisView extends StatelessWidget {
  const DadosAtuaisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dados Atuais"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Últimas Leituras",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            // 🔥 GRID DOS CARDS
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.95,
                children: const [
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

            const SizedBox(height: 8),

            // Info extra
            const Text(
              "Última leitura: 16/11/2025 - 11:45",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
