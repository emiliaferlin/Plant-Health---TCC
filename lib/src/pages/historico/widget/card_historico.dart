import 'package:flutter/material.dart';

class CardHistorico extends StatelessWidget {
  final item;
  const CardHistorico({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📌 Data e hora
            Text(
              item["data"]!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),

            const Divider(height: 20),

            // 🔥 Temperatura
            widgetInformacoes(
              Icons.thermostat,
              Colors.red,
              "Temperatura",
              item["temp"]!,
            ),

            const SizedBox(height: 8),

            // 💧 Umidade do Ar
            widgetInformacoes(
              Icons.water_drop,
              Colors.blue,
              "Umidade do Ar",
              item["umidadeAr"]!,
            ),

            const SizedBox(height: 8),

            // 🌱 Umidade do Solo
            widgetInformacoes(
              Icons.eco,
              Colors.brown,
              "Umidade do Solo",
              item["umidadeSolo"]!,
            ),

            const SizedBox(height: 8),

            // ☀️ Luminosidade
            widgetInformacoes(
              Icons.wb_sunny,
              Colors.amber,
              "Luminosidade",
              item["luz"]!,
            ),
          ],
        ),
      ),
    );
  }

  Widget widgetInformacoes(
    IconData icon,
    Color color,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, color: color, size: 26),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(fontSize: 16)),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
