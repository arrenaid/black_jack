import 'dart:io';

import 'package:black_jack/black_jack.dart';
import 'package:black_jack/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet.dart';
import 'cards_gridview_widget.dart';

class BlackJackScreen extends StatefulWidget {
  const BlackJackScreen({Key? key}) : super(key: key);

  @override
  State<BlackJackScreen> createState() => BlackJackScreenState();
}

class BlackJackScreenState extends State<BlackJackScreen> {
  bool isGameStart = false;
  late BlackJack _blackJack;
  bool isFinish = false;
  int _score = 0;

  void _showModalBottomSheet(BuildContext context)  {
    showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheetContent(game: _blackJack,score: _score,));
  }

  void startGame() async {
    setState(() {
      isGameStart = true;
      isFinish = false;
      _blackJack =  BlackJack();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //playingCards.addAll(deckOfCards);
  }

  void  hit() async{
    setState(()  {
      _blackJack.hitPlayer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      body: !isGameStart
          ? Center(
              child: Column(
                children: [
                  Image(image: BlackJack.coverCard.image),
                  SizedBox(height: 50),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    elevation: 15,
                    onPressed: startGame,
                    child: const Text("Start Black Jack", style: sampleTS),
                    color: Colors.brown[300],
                  ),
                ],
              ),
            )
          : SafeArea(
              child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //dealer
                  Column(
                    children: [
                      CardsGridView(
                        cards: _blackJack.dealer.cards,
                        isDealer: true,
                        finish: isFinish,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Dealer score: ${_blackJack.dealer.score}",
                        style: sampleTS,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Player score: ${_blackJack.player.score}",
                        style: _blackJack.player.score > 21 ? loseTS : sampleTS,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CardsGridView(
                          cards: _blackJack.player.cards,
                          isDealer: false,
                          finish: isFinish),
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
                            if(!isFinish) {
                              hit();
                            } else {
                              _showModalBottomSheet(context);
                              //sleep(Duration(seconds: 1));
                              setState(() {
                                isGameStart = false;
                              });
                            }
                          },
                          child: const Text(
                            "Hit",
                            style: sampleTS,
                          ),
                          color: Colors.brown[300],
                        ),
                        MaterialButton(
                          onPressed: () {
                            if(!isFinish) {
                              _stand();
                            } else {
                              _showModalBottomSheet(context);
                              //sleep(Duration(seconds: 1));
                              setState(() {
                                isGameStart = false;
                              });
                            }
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
    );
  }

  void _stand() {
    setState(() {
      isFinish = true;
      _blackJack.hitDealer();
    });
    _blackJack.winner();
    _score+=_blackJack.sessionScore;
    //sleep(Duration(seconds: 1));
  }
}
