import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_health/src/pages/dashboard/dashboard_view.dart';
import 'package:plant_health/src/pages/historico/historico_view.dart';
import 'package:plant_health/src/pages/sair/sair_view.dart';
import 'package:plant_health/src/shared/text_style/textstyle.dart';

class NavigattonBarViews extends StatefulWidget {
  final int? indexView;
  const NavigattonBarViews({super.key, this.indexView});

  @override
  State<NavigattonBarViews> createState() => _NavigattonBarViewsState();
}

class _NavigattonBarViewsState extends State<NavigattonBarViews> {
  int selectedIndex = 0;
  User? currentUser;

  @override
  void initState() {
    selectedIndex = widget.indexView ?? 0;
    FirebaseAuth.instance.authStateChanges().listen((user) {
      // fica ouvindo qualquer alteração de autenticação
      setState(() {
        currentUser = user;
      });
    });
    super.initState();
  }

  final List<Widget> pages = const [
    DashboardView(),
    //DadosAtuaisView(),
    HistoricoView(),
    SairView(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Colors.green.withOpacity(0.15),
          shadowColor: Colors.green.withOpacity(0.15),
          labelTextStyle: MaterialStateProperty.all(
            PlantTextStyle.bodySM(color: Colors.black),
          ),
        ),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onItemTapped,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.sensors),
              label: "Dashboard",
            ),
            // NavigationDestination(
            //   icon: Icon(Icons.sensors),
            //   label: "Dados Atuais",
            // ),
            NavigationDestination(
              icon: Icon(Icons.history),
              label: "Histórico",
            ),
            NavigationDestination(icon: Icon(Icons.logout), label: "Sair"),
          ],
        ),
      ),
    );
  }
}
