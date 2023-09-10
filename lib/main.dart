import 'package:flutter/material.dart';
import 'package:widget_golden_tests_example/bird_calc/bird_calc_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BirdCalcPage(),
    );
  }
}
