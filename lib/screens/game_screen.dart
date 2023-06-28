import 'dart:ui';
import 'package:black_jack/constants.dart';
import 'package:black_jack/cubit/jack_cubit.dart';
import 'package:black_jack/widget/horisontal_animated_list_view_widget.dart';
import 'package:black_jack/screens/winner_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/top_panel_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);
  static const String name = "game_screen";

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with TickerProviderStateMixin {


  late AnimationController _controller;
  late AnimationController _controllerSize;
  bool isVisibleButton = false;
  bool isVisibleFinalButton = false;

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
    super.initState();
    context.read<JackCubit>().restart();
    _controller.forward().whenComplete(() {
      setState(() {
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
            body: SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.teal[300],
                      borderRadius:  BorderRadius.circular(250),
                      border: Border.all(width: 3, color: const Color(0xff26a69a))
                    ),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ////TOP
                        TopPanelWidget(),
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
                          //height: MediaQuery.of(context).size.height /10,
                          decoration: BoxDecoration(
                            color: Colors.red[800],
                            borderRadius: BorderRadius.circular(dfltRadius),
                          ),
                          child: FadeTransition(
                            opacity:
                            _controller.drive(Tween(begin: 1.0, end: 0.0)),
                            child: Text(
                              "${state.blackJack.dealer
                                  .score} - Dealer \n\t\t\t\t\t\t\tVS \n\t\t\t\t\tPlayer - ${state
                                  .blackJack.get().score}",
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
                        ////BOTTOM
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/10,
                          decoration: BoxDecoration(
                            color: Colors.red[800],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(dfltRadius),
                              topRight: Radius.circular(dfltRadius),
                            ),
                          ),
                          child:
                          SlideTransition(
                            position: _controllerSize.drive(Tween(
                                begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))),
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
                                          _controllerSize.reverse()
                                              .whenComplete(() {
                                            setState(() {
                                              isVisibleFinalButton = false;
                                              isVisibleButton = false;
                                            });
                                            Navigator.pushReplacementNamed(
                                                context, WinnerScreen.name);
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
                                            _controllerSize.reverse()
                                                .whenComplete(() {
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
                        ),
                      ],
                    ),
                  ),
                )),
          );
        });
  }
}
