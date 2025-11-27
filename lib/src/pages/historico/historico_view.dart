import 'package:flutter/material.dart';
import 'package:plant_health/src/models/adafruit_model.dart';
import 'package:plant_health/src/pages/historico/widget/card_historico.dart';
import 'package:plant_health/src/services/adafruit_service.dart';
import 'package:plant_health/src/shared/constantes.dart';
import 'package:plant_health/src/shared/text_style/textstyle.dart';

class HistoricoView extends StatefulWidget {
  const HistoricoView({super.key});

  @override
  State<HistoricoView> createState() => _HistoricoViewState();
}

class _HistoricoViewState extends State<HistoricoView> {
  final service = AdafruitService(aioKey: "", username: "emiliaferlin");
  bool carregandoTela = false;
  List<FeedModel> umidade = [];
  List<FeedModel> umidadeSolo = [];
  List<FeedModel> temperatura = [];
  List<FeedModel> luminosidade = [];

  @override
  void initState() {
    super.initState();
    inicializaTela();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Histórico",
          style: PlantTextStyle.bodyXL(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      backgroundColor: Colors.grey[200],
      body:
          carregandoTela == true
              ? Center(child: CircularProgressIndicator(color: primaryColor))
              : SingleChildScrollView(
                child: Column(
                  children: [
                    CardHistorico(itens: umidade),
                    CardHistorico(itens: umidadeSolo),
                    CardHistorico(itens: temperatura),
                    CardHistorico(itens: luminosidade),
                  ],
                ),
              ),
    );
  }

  inicializaTela() async {
    setState(() {
      carregandoTela = true;
    });

    try {
      final responseUmidade = await service.buscaCadaFeedComLimiteDados(
        "umidade",
        30,
      );
      umidade =
          responseUmidade
              .map<FeedModel>((item) => FeedModel.fromMap(item))
              .toList();

      final responseUmidadeSolo = await service.buscaCadaFeedComLimiteDados(
        "umidade-solo",
        30,
      );
      umidadeSolo =
          responseUmidadeSolo
              .map<FeedModel>((item) => FeedModel.fromMap(item))
              .toList();

      final responseTemperatura = await service.buscaCadaFeedComLimiteDados(
        "temperatura",
        30,
      );
      temperatura =
          responseTemperatura
              .map<FeedModel>((item) => FeedModel.fromMap(item))
              .toList();

      final responseLuminosidade = await service.buscaCadaFeedComLimiteDados(
        "luminosidade",
        30,
      );
      luminosidade =
          responseLuminosidade
              .map<FeedModel>((item) => FeedModel.fromMap(item))
              .toList();

      setState(() {
        carregandoTela = false;
      });
    } catch (e) {
      setState(() {
        carregandoTela = false;
      });
      print("Erro: $e");
    }
  }
}
