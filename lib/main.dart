import 'package:flutter/material.dart';
import 'package:portfolio_performance_demo/portfolio_performance/portfolio_performance_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio Performance Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: PortfolioPerformanceScreen(),
    );
  }
}
