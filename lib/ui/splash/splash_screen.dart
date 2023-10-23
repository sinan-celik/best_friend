import 'package:best_friend/bloc/home/bloc/home_bloc.dart';
import 'package:best_friend/core/device_utils.dart';
import 'package:best_friend/core/theme_utils.dart';
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
      DeviceUtils().readVersion();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ThemeUtils.white,
      body: Center(
        child: Image.asset('assets/icon/icon.png'),
      ),
    );
  }
}
