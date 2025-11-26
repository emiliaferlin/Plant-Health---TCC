import 'dart:convert';
import 'package:http/http.dart' as http;

/// Serviço para comunicação com a API do Adafruit IO.
/// Basta configurar seu username e AIO Key abaixo.

class AdafruitService {
  final String username;
  final String aioKey;

  AdafruitService({required this.username, required this.aioKey});

  Map<String, String> get _headers => {
    'X-AIO-Key': aioKey,
    'Content-Type': 'application/json',
  };

  Future<dynamic> buscaCadaFeedComLimiteDados(String feedKey, int limit) async {
    final url = Uri.parse(
      "https://io.adafruit.com/api/v2/$username/feeds/$feedKey/data?limit=$limit",
    );

    final response = await http.get(url, headers: _headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Erro no histórico do feed $feedKey");
    }
  }

  Future<double> buscaUtimoDadoCadaFeed(String feedKey) async {
    final url = Uri.parse(
      "https://io.adafruit.com/api/v2/$username/feeds/$feedKey/data/last",
    );

    final response = await http.get(url, headers: _headers);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return double.parse(json["value"].toString());
    } else {
      throw Exception("Erro ao buscar feed $feedKey: ${response.statusCode}");
    }
  }

  Future<List<double>> buscaCadaFeedComValorComLimiteDados(
    String feedKey,
    int limit,
  ) async {
    final url = Uri.parse(
      "https://io.adafruit.com/api/v2/$username/feeds/$feedKey/data?limit=$limit",
    );

    final response = await http.get(url, headers: _headers);

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list
          .map((e) => double.tryParse(e["value"].toString()) ?? 0.0)
          .toList();
    } else {
      throw Exception("Erro no histórico do feed $feedKey");
    }
  }
}
