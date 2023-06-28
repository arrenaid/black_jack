import 'package:black_jack/cubit/coin_bloc.dart';
import 'package:black_jack/cubit/jack_cubit.dart';
import 'package:black_jack/screens/game_screen.dart';
import 'package:black_jack/screens/start_screen.dart';
import 'package:black_jack/widget/top_panel_widget.dart';
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
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const TopPanelWidget(),
                    Container(
                      height: 70,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.amber[200],
                      width: double.infinity,
                      child: Text("Your result ${game.get().name} - ${game.get().result ?? 'no'}",
                        style: sampleTS,),
                    ),
                    const Divider(thickness: 1),
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: players.length,
                        itemBuilder: (context,index){
                      return Container(
                        height: 125,
                        margin: EdgeInsets.symmetric(vertical: 2.5,horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.teal[400],
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 3,
                                color: Colors.teal)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(  " ${players[index].name} ${players[index].score.toString()} ${players[index].result}",style: sampleTS),
                                Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  height: 80,
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: players[index].cards.length,//game.listPlayer[index].cards.length,
                                      itemBuilder: (context,item){
                                        return Container(width: 50 ,  child: Image.asset(players[index].cards[item], fit: BoxFit.fitWidth,));
                                      }),
                                ),
                               ],
                            ),
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
