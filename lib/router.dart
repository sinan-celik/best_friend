import 'package:best_friend/ui/home/home_screen.dart';
import 'package:best_friend/ui/settings/settings_screen.dart';
import 'package:best_friend/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: <RouteBase>[
    GoRoute(
      path: '/splash',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'settings',
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsScreen();
          },
        ),
      ],
    ),
  ],
);
