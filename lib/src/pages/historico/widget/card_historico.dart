import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:intl/intl.dart';
import 'package:plant_health/src/models/adafruit_model.dart';

class CardHistorico extends StatefulWidget {
  final List<FeedModel>? itens;
  const CardHistorico({super.key, this.itens});

  @override
  _CardHistoricoState createState() => _CardHistoricoState();
}

class _CardHistoricoState extends State<CardHistorico> {
  final GlobalKey<ExpansionTileCardState> cardKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final lista = widget.itens ?? [];

    // Pega o primeiro item apenas para definir título, ícone e cor
    final primeiro = lista.isNotEmpty ? lista.first : null;

    final key = primeiro?.feedKey ?? '';
    final color = getCardColor(key);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: ExpansionTileCard(
        key: cardKey,

        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(getIcon(key), color: Colors.black87),
        ),

        title: Text(
          getTitulo(key),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),

        children: <Widget>[
          const Divider(thickness: 1.0, height: 1.0),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final item = lista[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Valor: ${item.value}",
                      style: const TextStyle(fontSize: 17),
                    ),
                    Text(
                      item.createdAt != null
                          ? formatarData(item.createdAt!)
                          : '--',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String getTitulo(String key) {
    switch (key) {
      case 'umidade':
        return 'Umidade do Ar';
      case 'umidade-solo':
        return 'Umidade do Solo';
      case 'temperatura':
        return 'Temperatura';
      case 'luminosidade':
        return 'Luminosidade';
      default:
        return 'Desconhecido';
    }
  }

  IconData getIcon(String key) {
    switch (key) {
      case 'umidade':
        return Icons.water_drop;
      case 'umidade-solo':
        return Icons.grass;
      case 'temperatura':
        return Icons.thermostat_outlined;
      case 'luminosidade':
        return Icons.wb_sunny_outlined;
      default:
        return Icons.device_unknown;
    }
  }

  Color getCardColor(String key) {
    switch (key) {
      case 'umidade':
        return const Color.fromRGBO(170, 220, 245, 1); // azul claro
      case 'umidade-solo':
        return const Color.fromRGBO(190, 240, 185, 1); // verde claro
      case 'temperatura':
        return const Color.fromRGBO(255, 220, 180, 1); // laranja claro
      case 'luminosidade':
        return const Color.fromRGBO(255, 245, 180, 1); // amarelo claro
      default:
        return Colors.grey;
    }
  }

  String formatarData(DateTime data) {
    final local = data.toLocal();
    return DateFormat('dd/MM/yyyy - HH:mm').format(local);
  }
}
