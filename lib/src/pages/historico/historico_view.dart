import 'package:flutter/material.dart';
import 'package:plant_health/src/pages/historico/widget/card_historico.dart';

class HistoricoView extends StatelessWidget {
  const HistoricoView({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔥 Exemplo de dados (depois você troca pelos reais)
    final historico = [
      {
        "data": "16/11/2025 18:30",
        "temp": "25.3 °C",
        "umidadeAr": "61%",
        "umidadeSolo": "46%",
        "luz": "742 lx",
      },
      {
        "data": "16/11/2025 18:00",
        "temp": "24.8 °C",
        "umidadeAr": "59%",
        "umidadeSolo": "44%",
        "luz": "710 lx",
      },
      {
        "data": "16/11/2025 17:30",
        "temp": "26.0 °C",
        "umidadeAr": "62%",
        "umidadeSolo": "48%",
        "luz": "765 lx",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Histórico"),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: historico.length,
        itemBuilder: (_, index) {
          final item = historico[index];
          return CardHistorico(item: item);
        },
      ),
    );
  }
}
