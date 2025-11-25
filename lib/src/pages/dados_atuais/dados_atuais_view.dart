import 'package:flutter/material.dart';
import 'package:plant_health/src/pages/dados_atuais/widget/card/card_informacoes_dados_atuais.dart';
import 'package:plant_health/src/pages/dados_atuais/widget/card/card_luminosidade_dados_atuais.dart';
import 'package:plant_health/src/pages/dados_atuais/widget/card/card_temperatura_dados_atuais.dart';
import 'package:plant_health/src/pages/dados_atuais/widget/card/card_umidade_ar_dados_atuais.dart';
import 'package:plant_health/src/pages/dados_atuais/widget/card/card_umidade_solo_dados_atuais.dart';
import 'package:plant_health/src/pages/dados_atuais/widget/indicador_rapido_dados_atuais.dart';
import 'package:plant_health/src/services/adafruit_service.dart';
import 'package:plant_health/src/shared/constantes.dart';
import 'package:plant_health/src/shared/text_style/textstyle.dart';

class DadosAtuaisView extends StatefulWidget {
  const DadosAtuaisView({super.key});

  @override
  State<DadosAtuaisView> createState() => _DadosAtuaisViewState();
}

class _DadosAtuaisViewState extends State<DadosAtuaisView> {
  final service = AdafruitService(aioKey: "", username: "emiliaferlin");
  bool carregandoTela = false;

  double temperatura = 0.0;
  double umidadeAr = 0.0;
  double umidadeSolo = 0.0;
  double luminosidade = 0.0;
  String lastReading = "--/--";
  List<double> toleranciaMensal = [];
  List<double> tempSeries = [];

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
          'Dashboard',
          style: PlantTextStyle.bodyXL(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      backgroundColor: Colors.grey[200],
      body:
          carregandoTela == true
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              CardInformacoes(
                                title: 'Umidade do Ar',
                                color: Colors.white,
                                child: CardUmidadeArDashboard(value: umidadeAr),
                              ),
                              SizedBox(height: 12),
                              CardInformacoes(
                                title: 'Umidade do Solo',
                                color: Colors.white,
                                child: CardUmidadeSolo(value: umidadeSolo),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: CardInformacoes(
                            title: 'Luminosidade',
                            color: Colors.white,
                            child: CardLuminosidade(value: luminosidade),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    CardInformacoes(
                      title: 'Temperatura',
                      color: Colors.white,
                      child: CardTemperaturaDashboard(
                        value: temperatura,
                        series: tempSeries,
                      ),
                    ),
                    SizedBox(height: 12),
                    IndicadorRapido(
                      label: 'Última leitura',
                      value: lastReading,
                    ),
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
      lastReading =
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} - ${DateTime.now().hour}:${DateTime.now().minute}";

      temperatura = await service.getLastValue("temperatura");
      tempSeries = await service.getFeedHistory("temperatura", 24);
      toleranciaMensal = await service.getFeedHistory("temperatura", 30);
      umidadeAr = await service.getLastValue("umidade");
      luminosidade = await service.getLastValue("luminosidade");
      umidadeSolo = await service.getLastValue("umidade_solo");

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
