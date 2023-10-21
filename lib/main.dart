import 'package:best_friend/bloc/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';

void main() {


  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(),
          )
        ],
        child: const MyApp(),
      ),
    );
}

