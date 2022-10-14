import 'dart:ffi';

import 'package:black_jack/cubit/jack_cubit.dart';
import 'package:black_jack/screens/game_screen.dart';
import 'package:black_jack/screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../black_jack.dart';
import '../constants.dart';

class WinnerScreen extends StatefulWidget {
  const WinnerScreen({Key? key}) : super(key: key);
  static const String name = "winner_screen";

  @override
  State<WinnerScreen> createState() => _WinnerScreenState();
}

class _WinnerScreenState extends State<WinnerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JackCubit,JackState>(
      builder: (context, state) {
        String result = state.blackJack.winner();
        final BlackJack game = state.blackJack;
        final int score = state.blackJack.player.score;
        return Scaffold(
          body: SafeArea(
            child: Container(
              color: Colors.teal[300],
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Container(
                    height: 100,
                    alignment: Alignment.center,
                    child: Image.asset("chip/chip500.png",),
                  ),
                  Container(
                      height: 100,
                      alignment: Alignment.center,
                      child: Image.asset("chip/chip300.png",)
                  ),
                  Container(
                      height: 100,
                      alignment: Alignment.center,
                      child: Image.asset("chip/chip100.png",)
                  ),

                  SizedBox(
                    height: 70,
                    child: Center(
                      child: Text( result,
                        style: loseTS,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const Divider(thickness: 1),
                  Container(
                    height: 70,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.amber[200],
                    width: double.infinity,
                    child: Text("Dealer: ${game.dealer.score} VS ${game.player.score} :Player",
                      style: sampleTS,),
                  ),
                  Container(
                    height: 30,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.brown[200],
                    width: double.infinity,
                    child: Text("Score: $score",
                      style: sampleTS,),
                  ),
                  MaterialButton(
                    onPressed:  (){
                      Navigator.pushReplacementNamed(context, GameScreen.name);
                    },
                    child: const Text("New Game", style: sampleTS),
                    color: Colors.brown[300],
                  ),
                  MaterialButton(
                    onPressed:  (){
                      Navigator.pushReplacementNamed(context, StartScreen.name);
                    },
                    child: const Text("Start", style: sampleTS),
                    color: Colors.brown[300],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
