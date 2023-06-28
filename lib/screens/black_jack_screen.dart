import 'package:black_jack/black_jack.dart';
import 'package:black_jack/constants.dart';
import 'package:black_jack/cubit/jack_cubit.dart';
import 'package:black_jack/widget/horisontal_animated_list_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/bottom_sheet.dart';

class BlackJackScreen extends StatefulWidget {
  const BlackJackScreen({Key? key}) : super(key: key);

  @override
  State<BlackJackScreen> createState() => BlackJackScreenState();
}

class BlackJackScreenState extends State<BlackJackScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controllerSize;
  bool isGameStart = false;
  bool isVisibleButton = false;
  bool isVisibleFinalButton = false;



  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheetContent(
              game: context.read<JackCubit>().state.blackJack, //_blackJack,
              score: context.read<JackCubit>().state.score, //_score,
            ));
  }

  void startGame() async {
    _controller.forward().whenComplete(() {
      context.read<JackCubit>().restart();
      setState(() {
        isGameStart = true;
        _controller.reverse().whenComplete(() {
          _controller.forward().whenComplete(() {
            context.read<JackCubit>().dealer();
            _controller.reverse().whenComplete(() {
              _controller.forward().whenComplete(() {
                context.read<JackCubit>().player();
                _controller.reverse().whenComplete(() {
                  _controller.forward().whenComplete(() {
                    context.read<JackCubit>().dealer();
                    _controller.reverse().whenComplete(() {
                      _controller.forward().whenComplete(() {
                        context.read<JackCubit>().player();
                        _controller.reverse();
                        setState(() {
                          isVisibleButton = true;
                          _controllerSize.forward();//.whenComplete(() => _controllerSize.reset());
                        });
                      });
                    });
                  });
                });
              });
            });
          });
        });
      });
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _controllerSize = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _controller.reset();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerSize.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JackCubit, JackState>(
        buildWhen: (prevState, currentState) => (prevState != currentState),
        builder: (context, state) {
          return Scaffold(
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
                            child:
                                const Text("Start Black Jack", style: sampleTS),
                            color: Colors.brown[300],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SlideTransition(
                                position: _controller.drive(Tween<Offset>(
                                    begin: const Offset(0.0, 0.0),
                                    end: const Offset(0.0, 2.0))),
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
                        HorizontalListWidget(
                          cards: state.blackJack.dealer.cards,
                          isDealer: true,
                          finish: state.isFinish,
                          controller: _controller,
                        ),
                        ////SCORE
                        Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(5),
                          child: FadeTransition(
                            opacity:
                                _controller.drive(Tween(begin: 1.0, end: 0.0)),
                            child: Text(
                              "${state.blackJack.dealer.score} - Dealer \n\t\t\t\t\t\t\tVS \n\t\t\t\t\tPlayer - ${state.blackJack.get().score}",
                              style: state.blackJack.get().score > 21
                                  ? loseTS
                                  : sampleTS,
                            ),
                          ),
                        ),
                        ////PLAYER
                        HorizontalListWidget(
                          cards: state.blackJack.get().cards,
                          isDealer: false,
                          finish: state.isFinish,
                          controller: _controller,
                        ),
                        SlideTransition(

                          position: _controllerSize.drive(Tween(begin: Offset(0.0, 1.0),end: Offset(0.0,0.0))),
                          child: IntrinsicWidth(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                isVisibleButton ? MaterialButton(
                                  onPressed: () {
                                    _controller.forward().whenComplete(() {
                                      if (!state.isFinish) {
                                        context.read<JackCubit>().hit(); //hit();
                                      } else {
                                        _showModalBottomSheet(context);
                                        //sleep(Duration(seconds: 1));
                                        setState(() {
                                          isVisibleFinalButton = true;
                                          //isGameStart = false;
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
                                ) : Container(height: 30,),
                                isVisibleFinalButton ? MaterialButton(
                                  onPressed: () {
                                    _controller.forward().whenComplete(() {
                                      _controller.reverse().whenComplete(() {
                                        _controllerSize.reverse().whenComplete(() {
                                        setState(() {
                                          //sleep(Duration(seconds: 1));
                                          //_showModalBottomSheet(context);
                                          isVisibleFinalButton = false;
                                          isVisibleButton = false;
                                          isGameStart = false;
                                          });
                                        });
                                      });
                                    });
                                  },
                                  child: const Text(
                                    "...Finishing...",
                                    style: sampleTS,
                                  ),
                                  color: Colors.deepOrange[300],
                                ) : Container(),
                                isVisibleButton ? MaterialButton(
                                  onPressed: () {
                                    _controller.forward().whenComplete(() {
                                      context.read<JackCubit>().stand();
                                      _controller.reset();
                                      _controller.reset();
                                      _controller.fling().whenComplete(() {
                                        _controller.reverse().whenComplete(() {
                                          _controllerSize.reverse().whenComplete(() {
                                          setState(() {
                                            isVisibleFinalButton = true;
                                            isVisibleButton = false;
                                            _controllerSize.forward();
                                            });
                                          });
                                        });
                                      });
                                    });

                                  },
                                  child: const Text(
                                    "Stand",
                                    style: sampleTS,
                                  ),
                                  color: Colors.amber[300],
                                ) : Container(height: 30, width: 30,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
          );
        });
  }
}
