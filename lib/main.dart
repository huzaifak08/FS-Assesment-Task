import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fs_task_assesment/helpers/app_data.dart';
import 'package:fs_task_assesment/helpers/app_provider_container.dart';
import 'package:fs_task_assesment/views/splash/splash_view.dart';

void main() async {
  // Ensure Initialization:
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase:
  await Firebase.initializeApp();

  // Run App:
  runApp(
    ProviderScope(
      child: UncontrolledProviderScope(
        container: AppProviderContainer.instance,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      navigatorKey: AppData.shared.navigatorKey,
      home: const SplashView(),
    );
  }
}
