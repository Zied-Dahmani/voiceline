import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:voiceline/config/app_bloc_observer.dart';
import 'package:voiceline/config/injection.dart';

class InitializationManager {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load();
    Bloc.observer = AppBlocObserver();
    setupInjection();
  }
}