import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widget_golden_tests_example/bird_calc/bird_calc_page.dart';
import 'package:widget_golden_tests_example/bird_calc/logic.dart';

void main() {
  runApp(const MyApp());
}

final random = Random();
final calc = BirdCalc(random);
final store = Store(AppState.initState, calc);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BirdCalcPage(store: store,),
    );
  }
}
