import 'dart:io';
import 'package:black_jack/black_jack.dart';
import 'package:black_jack/constants.dart';
import 'package:black_jack/cubit/jack_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bottom_sheet.dart';
import 'cards_gridview_widget.dart';

class BlackJackScreen extends StatefulWidget {
  const BlackJackScreen({Key? key}) : super(key: key);

  @override
  State<BlackJackScreen> createState() => BlackJackScreenState();
}

class BlackJackScreenState extends State<BlackJackScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isGameStart = false;
  // late BlackJack _blackJack;
  // bool isFinish = false;
  // int _score = 0;

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheetContent(
              game: context.read<JackCubit>().state.blackJack,//_blackJack,
              score: context.read<JackCubit>().state.score,//_score,
            ));
  }

  void startGame() async {
    _controller.forward().whenComplete(() {
      context.read<JackCubit>().restart();
      setState(() {
      isGameStart = true;
      // isFinish = false;
      // _blackJack = BlackJack();
        _controller.reverse();
      });
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    super.initState();
    //playingCards.addAll(deckOfCards);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void hit() async {
  //   setState(() {
  //     _blackJack.hitPlayer();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JackCubit,JackState>(
      buildWhen:  (prevState,currentState) => (prevState!=currentState),
      builder: (context, state) {return Scaffold(
        backgroundColor: Colors.teal[200],
        body: !isGameStart
            ? Center(
                child: Stack(
                  children: [
                    Align(
                      alignment: const FractionalOffset(0.5, 0.8),
                      child: MaterialButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        elevation: 15,
                        onPressed: startGame,
                        child: const Text("Start Black Jack", style: sampleTS),
                        color: Colors.brown[300],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SlideTransition(
                            //alignment: _controller.drive(Tween(begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                            position: _controller.drive(Tween<Offset>(
                                begin: const Offset(0.0, 0.0),
                                end: const Offset(0.0, 1.0))),
                            child: Image(image: BlackJack.coverCard.image)),
                      ],
                    ),
                  ],
                ),
              )
            : SafeArea(
                child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ////DEALER
                    Column(
                      children: [
                        CardsGridView(
                          cards: state.blackJack.dealer.cards,//context.read<JackCubit>().state.blackJack.dealer.cards,//_blackJack.dealer.cards,
                          isDealer: true,
                          finish: state.isFinish,//context.read<JackCubit>().state.isFinish,
                          controller: _controller,
                        ),
                      ],
                    ),
                    ////SCORE
                    Container(
                      //color: Colors.red[300],
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(5),
                      child: FadeTransition(
                        opacity: _controller.drive(Tween(begin: 1.0, end: 0.0)),
                        child: Text(
                          "${state.blackJack.dealer.score} - Dealer \n\t\t\t\t\t\t\tVS \n\t\t\t\t\tPlayer - ${state.blackJack.player.score}",
                          style: state.blackJack.player.score > 21 ? loseTS : sampleTS,
                        ),
                      ),
                    ),

                    Column(
                      children: [
                        CardsGridView(
                            cards: state.blackJack.player.cards,
                            isDealer: false,
                            finish: state.isFinish,
                          controller: _controller,
                        ),
                      ],
                    ),
                    IntrinsicWidth(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              _controller.forward().whenComplete(() {
                                if (!state.isFinish) {
                                  context.read<JackCubit>().hit();//hit();
                                } else {
                                  _showModalBottomSheet(context);
                                  //sleep(Duration(seconds: 1));
                                  setState(() {
                                    isGameStart = false;
                                  });
                                }
                                _controller.reverse();
                              });
                            },
                            child: const Text(
                              "Hit",
                              style: sampleTS,
                            ),
                            color: Colors.brown[300],
                          ),
                          MaterialButton(
                            onPressed: () {
                              _controller.forward().whenComplete(() {
                                context.read<JackCubit>().stand();
                                _controller.reverse().whenComplete(() {
                                  setState(() {
                                    sleep(Duration(seconds: 1));
                                    _showModalBottomSheet(context);
                                    isGameStart = false;
                                  });
                                });
                              });
                            },
                            child: const Text(
                              "Stand",
                              style: sampleTS,
                            ),
                            color: Colors.amber[300],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
      );}
    );
  }

  // void _stand() {
  //   setState(() {
  //     isFinish = true;
  //     _blackJack.hitDealer();
  //   });
  //   _blackJack.winner();
  //   _score += _blackJack.sessionScore;
  //   //sleep(Duration(seconds: 1));
  // }
}
