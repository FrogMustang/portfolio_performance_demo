import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/portfolio_overview_module.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/portfolio_performance_module.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/portfolio_performance_screen.dart';
import 'package:portfolio_performance_demo/theme/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize mock gRPC server
  await PortfolioPerformanceModule.initialize();
  await PortfolioOverviewModule.initialize();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          title: 'Portfolio Performance Demo',
          theme: themeState.themeData,
          debugShowCheckedModeBanner: false,
          home: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    PortfolioPerformanceModule.providePortfolioPerformanceBloc(),
              ),
              BlocProvider(
                create: (context) =>
                    PortfolioOverviewModule.providePortfolioOverviewBloc(),
              ),
            ],
            child: const PortfolioPerformanceScreen(),
          ),
        );
      },
    );
  }
}
