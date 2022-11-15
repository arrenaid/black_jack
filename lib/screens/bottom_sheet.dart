import 'package:black_jack/black_jack.dart';
import 'package:black_jack/cubit/jack_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';

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
            child: Text("Dealer: ${game.dealer.score} VS ${game.get().score} :Player",
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
class BottomSheetSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JackCubit,JackState>(
      builder: (context,state) {
        final BlackJackList game = state.blackJack;
        List<Player> players = [];
        players.add(game.dealer);
        players.addAll(game.listPlayer);

        return Container(
          color: Colors.teal[300],
          height: MediaQuery.of(context).size.height/5,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.amber[200],
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Players: ${state.numberPlayers}",
                        style: sampleTS,),
                      Row(
                        children: [
                          MaterialButton(
                            onPressed:  (){
                              context.read<JackCubit>().changeNumberOfPlayers(--state.numberPlayers);
                            },
                            child: const Text("Remove", style: sampleTS),
                            color: Colors.brown[300],
                          ),
                          MaterialButton(
                            onPressed:  (){
                              context.read<JackCubit>().changeNumberOfPlayers(++state.numberPlayers);
                            },
                            child: const Text("Insert", style: sampleTS),
                            color: Colors.brown[300],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}