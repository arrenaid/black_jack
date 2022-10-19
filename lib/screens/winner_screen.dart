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
        final BlackJackList game = state.blackJack;
        List<Player> players = [];
        players.add(game.dealer);
        players.addAll(game.listPlayer);
        return Scaffold(
          body: SafeArea(
            child: Container(
              color: Colors.teal[300],
              height: double.infinity,
              child:
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 70,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.amber[200],
                      width: double.infinity,
                      child: Text("Your result ${game.get().name} - ${game.get().result}",
                        style: sampleTS,),
                    ),
                    const Divider(thickness: 1),
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: players.length,// game.listPlayer.length,
                        itemBuilder: (context,index){
                      return Container(
                        height: 125,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 3,
                                color: Colors.greenAccent)),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(players[index].name,style: sampleTS),//Text(game.listPlayer[index].name,style: sampleTS),
                                Text(players[index].score.toString(),style: sampleTS),
                                Text(players[index].result,style: sampleTS),
                                Text(players[index].sessionScore.toString(),style: sampleTS),
                              ],
                            ),
                            ListView.builder(
                            //physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            //physics: ClampingScrollPhysics(),
                                physics: PageScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: players[index].cards.length,//game.listPlayer[index].cards.length,
                            itemBuilder: (context,item){
                              return Container(width: 50 ,  child: Image.asset(players[index].cards[item], fit: BoxFit.fitWidth,));
                            }),
                            // Container(width: 50, child: Image.asset(game.listPlayer[index].cards.first)),

                          ],
                        ),
                      );
                    }),
                    const Divider(thickness: 1),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            onPressed:  (){
                              Navigator.pushReplacementNamed(context, GameScreen.name);
                            },
                            child: const Text("New Game", style: sampleTS),
                            color: Colors.deepOrange[300],
                          ),
                          MaterialButton(
                            onPressed:  (){
                              Navigator.pushReplacementNamed(context, StartScreen.name);
                            },
                            child: const Text("Start", style: sampleTS),
                            color: Colors.amber[300],
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   height: 30,
                    //   alignment: Alignment.center,
                    //   padding: EdgeInsets.symmetric(horizontal: 5),
                    //   color: Colors.brown[200],
                    //   width: double.infinity,
                    //   child: Text("Score: $score",
                    //     style: sampleTS,),
                    // ),

                    //const Divider(thickness: 1),
                    // SizedBox(
                    //   height: 25,
                    //   child: Center(
                    //     child: Text( result,
                    //       style: loseTS,
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       height: 100,
                    //       alignment: Alignment.center,
                    //       child: Image.asset("chip/chip500.png",),
                    //     ),
                    //     Container(
                    //         height: 100,
                    //         alignment: Alignment.center,
                    //         child: Image.asset("chip/chip300.png",)
                    //     ),
                    //     Container(
                    //         height: 100,
                    //         alignment: Alignment.center,
                    //         child: Image.asset("chip/chip100.png",)
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
