import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fs_task_assesment/helpers/app_data.dart';
import 'package:fs_task_assesment/helpers/app_provider_container.dart';
import 'package:fs_task_assesment/helpers/themes.dart';
import 'package:fs_task_assesment/providers/theme_provider.dart';
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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: currentTheme,
      theme: lightTheme,
      darkTheme: darkTheme,
      navigatorKey: AppData.shared.navigatorKey,
      home: const SplashView(),
    );
  }
}
