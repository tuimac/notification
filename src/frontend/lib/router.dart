import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/widgets/auth/main.dart';
import 'package:frontend/widgets/main/main.dart';
import 'package:frontend/widgets/systemConfig/main.dart';
import 'package:frontend/widgets/systemLogs/main.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const Authentication();
          }),
      GoRoute(
          path: '/main',
          builder: (BuildContext context, GoRouterState state) {
            return const MainWidget();
          }),
      GoRoute(
          path: '/systemconfig',
          builder: (BuildContext context, GoRouterState state) {
            return const SystemConfig();
          }),
      GoRoute(
          path: '/systemlogs',
          builder: (BuildContext context, GoRouterState state) {
            return const SystemLogs();
          }),
    ],
  );

  static GoRouter get router => _router;
}
