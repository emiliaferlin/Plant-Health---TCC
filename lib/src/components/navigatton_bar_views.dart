import 'package:flutter/material.dart';
import 'package:plant_health/src/pages/dados_atuais/dados_atuais_view.dart';
import 'package:plant_health/src/pages/dashboard/dashboard_view.dart';
import 'package:plant_health/src/pages/historico/historico_view.dart';
import 'package:plant_health/src/pages/login/login_view.dart';
import 'package:plant_health/src/pages/sair/sair_view.dart';

class NavigattonBarViews extends StatefulWidget {
  const NavigattonBarViews({super.key});

  @override
  State<NavigattonBarViews> createState() => _NavigattonBarViewsState();
}

class _NavigattonBarViewsState extends State<NavigattonBarViews> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    LoginView(),
    DashboardView(),
    DadosAtuaisView(),
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

      // 🔥 Fundo branco garantido
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white, // fundo branco
          indicatorColor: Colors.green.withOpacity(0.15),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(color: Colors.black),
          ),
        ),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onItemTapped,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.login),
              selectedIcon: Icon(Icons.login_outlined),
              label: "Login",
            ),
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard),
              label: "Dashboard",
            ),
            NavigationDestination(
              icon: Icon(Icons.sensors),
              selectedIcon: Icon(Icons.sensors_outlined),
              label: "Dados Atuais",
            ),
            NavigationDestination(
              icon: Icon(Icons.history),
              selectedIcon: Icon(Icons.history_toggle_off),
              label: "Histórico",
            ),
            NavigationDestination(
              icon: Icon(Icons.logout),
              selectedIcon: Icon(Icons.logout),
              label: "Sair",
            ),
          ],
        ),
      ),
    );
  }
}
