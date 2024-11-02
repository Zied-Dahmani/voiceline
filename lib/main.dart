import 'package:flutter/material.dart';
import 'package:voiceline/config/initialization_manager.dart';
import 'package:voiceline/config/theme.dart';
import 'package:voiceline/presentation/screens/prediction_screen.dart';

void main() async {
  await InitializationManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voiceline',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      themeMode: ThemeMode.light,
      home: const PredictionScreen(),
    );
  }
}