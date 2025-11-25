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

  /// ---------------------------
  /// LISTAR TODOS OS FEEDS
  /// ---------------------------
  Future<List<dynamic>> listarFeeds() async {
    final url = Uri.parse('https://io.adafruit.com/api/v2/$username/feeds');

    final response = await http.get(url, headers: _headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'Erro ao buscar feeds: ${response.statusCode} → ${response.body}',
      );
    }
  }

  /// ---------------------------
  /// CRIAR UM FEED
  /// ---------------------------
  Future<Map<String, dynamic>> criarFeed(String nomeFeed) async {
    final url = Uri.parse('https://io.adafruit.com/api/v2/$username/feeds');

    final body = jsonEncode({"name": nomeFeed});

    final response = await http.post(url, headers: _headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'Erro ao criar feed: ${response.statusCode} → ${response.body}',
      );
    }
  }

  /// ---------------------------
  /// ENVIAR UM VALOR PARA UM FEED
  /// ---------------------------
  Future<bool> enviarValor(String feedKey, dynamic valor) async {
    final url = Uri.parse(
      'https://io.adafruit.com/api/v2/$username/feeds/$feedKey/data',
    );

    final body = jsonEncode({"value": valor});

    final response = await http.post(url, headers: _headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception(
        'Erro ao enviar valor: ${response.statusCode} → ${response.body}',
      );
    }
  }

  /// ---------------------------
  /// BUSCAR O ÚLTIMO VALOR DE UM FEED
  /// ---------------------------
  Future<Map<String, dynamic>> buscarUltimoValor(String feedKey) async {
    final url = Uri.parse(
      'https://io.adafruit.com/api/v2/$username/feeds/$feedKey/data/last',
    );

    final response = await http.get(url, headers: _headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'Erro ao buscar último valor: ${response.statusCode} → ${response.body}',
      );
    }
  }

  Future<double> getLastValue(String feedKey) async {
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

  Future<List<double>> getFeedHistory(String feedKey, int limit) async {
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
