import 'package:flutter/material.dart';
import 'package:plant_health/src/pages/login/auth.dart';
import 'package:plant_health/src/shared/constantes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant Health',
      color: primaryColor,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
      ),
      home: AuthScreen(),
    );
  }
}
