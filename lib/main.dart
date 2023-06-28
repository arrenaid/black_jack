import 'package:black_jack/cubit/coin_bloc.dart';
import 'package:black_jack/cubit/jack_cubit.dart';
import 'package:black_jack/screens/game_screen.dart';
import 'package:black_jack/screens/start_screen.dart';
import 'package:black_jack/screens/winner_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => JackCubit()),
        BlocProvider(create: (context) => CoinBloc()..add(LoadCoin())),
      ],
      child: MaterialApp(
        title: 'Black Jack',
        debugShowCheckedModeBanner: false,
        home: StartScreen(),
        routes: {
          StartScreen.name: (context) => StartScreen(),
          GameScreen.name: (context) => GameScreen(),
          WinnerScreen.name: (context) => WinnerScreen(),
        },
      ),
    );
  }
}
