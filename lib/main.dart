import 'package:black_jack/cubit/jack_cubit.dart';
import 'package:black_jack/screens/black_jack_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<JackCubit>(
      create: (context) => JackCubit(),
      child: MaterialApp(
        title: 'Black Jack',
        home: BlackJackScreen(),
      ),
    );
  }
}

