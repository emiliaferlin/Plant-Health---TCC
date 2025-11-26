import 'package:flutter/material.dart';
import 'package:plant_health/src/models/adafruit_model.dart';

class CardHistorico extends StatelessWidget {
  final FeedModel? item;
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
            Text(
              item?.createdAt?.toIso8601String() ?? "",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            Divider(height: 20),
            widgetInformacoes(
              Icons.thermostat,
              Colors.red,
              "Temperatura",
              item?.value ?? "",
            ),
            SizedBox(height: 8),
            widgetInformacoes(
              Icons.water_drop,
              Colors.blue,
              "Umidade do Ar",
              item?.value ?? "",
            ),
            SizedBox(height: 8),
            widgetInformacoes(
              Icons.eco,
              Colors.brown,
              "Umidade do Solo",
              item?.value ?? "",
            ),
            SizedBox(height: 8),
            widgetInformacoes(
              Icons.wb_sunny,
              Colors.amber,
              "Luminosidade",
              item?.value ?? "",
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
