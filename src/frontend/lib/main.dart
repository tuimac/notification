import 'package:flutter/material.dart';
import 'package:frontend/models/logs.dart';
import 'package:frontend/services/logService.dart';
import 'package:frontend/theme/main.dart';
import 'router.dart';

void main() {
  try {
    runApp(const MainApp());
  } catch (e) {
    LogService.write(Logs(message: e.toString()));
    rethrow;
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
      title: 'Utility',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.getDefault,
    );
  }
}
