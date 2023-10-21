import 'package:best_friend/bloc/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(Duration.zero, () {
      BlocProvider.of<HomeBloc>(context).add(FirstLoadEvent());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
