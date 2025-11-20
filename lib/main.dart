import 'package:flutter/material.dart';
import 'package:plant_health/src/components/navigatton_bar_views.dart';

const Color primaryColor = Color(0x0017A209);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Health',
      color: primaryColor,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const NavigattonBarViews(),
    );
  }
}
