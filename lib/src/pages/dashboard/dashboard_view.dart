import 'package:flutter/material.dart';
import 'package:plant_health/src/pages/dashboard/widget/card/card_informacoes_dashboard.dart';
import 'package:plant_health/src/pages/dashboard/widget/card/card_luminosidade_dashboard.dart';
import 'package:plant_health/src/pages/dashboard/widget/card/card_temperatura_dashboard.dart';
import 'package:plant_health/src/pages/dashboard/widget/card/card_umidade_ar_dashboard.dart';
import 'package:plant_health/src/pages/dashboard/widget/card/card_umidade_solo_dashboard.dart';
import 'package:plant_health/src/pages/dashboard/widget/indicador_rapido_dashboard.dart';
import 'package:plant_health/src/services/adafruit_service.dart';
import 'package:plant_health/src/shared/constantes.dart';
import 'package:plant_health/src/shared/text_style/textstyle.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final service = AdafruitService(
    aioKey: "aio_yXdD02sJ7lIn1bl6z29L7NsqJPxk",
    username: "emiliaferlin",
  );
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
