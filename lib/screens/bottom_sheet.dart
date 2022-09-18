import 'package:black_jack/black_jack.dart';
import 'package:black_jack/screens/black_jack_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class BottomSheetContent extends StatelessWidget {
  final BlackJack game;
  // final int dScore;
  // final int pScore;
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
              Navigator.of(context).pop();
            },
            child: const Text("New Game", style: sampleTS),
            color: Colors.brown[300],
          ),
        ],
      ),
    );
  }
}