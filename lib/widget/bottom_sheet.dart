import 'package:black_jack/black_jack.dart';
import 'package:black_jack/cubit/coin_bloc.dart';
import 'package:black_jack/cubit/jack_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';
import 'bet_widget.dart';

class BottomSheetContent extends StatelessWidget {
  final BlackJackList game;
  final int score;

  const BottomSheetContent({Key? key, required this.game, required this.score})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String result = game.winner();
    return Container(
      color: Colors.teal[300],
      height: 300,
      child: Column(
        children: [
          SizedBox(
            height: 70,
            child: Center(
              child: Text(
                result,
                style: tsLose,
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
            child: Text(
              "Dealer: ${game.dealer.score} VS ${game.get().score} :Player",
              style: tsSample,
            ),
          ),
          Container(
            height: 30,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 5),
            color: Colors.brown[200],
            width: double.infinity,
            child: Text(
              "Score: $score",
              style: tsSample,
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("New Game", style: tsSample),
            color: Colors.brown[300],
          ),
        ],
      ),
    );
  }
}