import 'package:best_friend/core/theme_utils.dart';
import 'package:best_friend/router.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Best Friend',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: ThemeUtils.white,
          primaryColor: Colors.black,
          fontFamily: 'Galano Grotesque',
          textTheme: const TextTheme(
              titleLarge:
                  TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              titleMedium: TextStyle(color: Colors.black54),
              titleSmall:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w800),
              displayLarge:
                  TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800))),
      
    );
  }
}
