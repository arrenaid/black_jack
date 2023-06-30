import 'dart:ui';
import 'package:black_jack/constants.dart';
import 'package:black_jack/cubit/jack_cubit.dart';
import 'package:black_jack/screens/start_screen.dart';
import 'package:black_jack/widget/hit_button.dart';
import 'package:black_jack/widget/horisontal_animated_list_view_widget.dart';
import 'package:black_jack/screens/winner_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../black_jack.dart';
import '../cubit/coin_bloc.dart';
import '../widget/bottom_sheet.dart';
import '../widget/pannel_blure_widget.dart';
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
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(5),
                            height: (MediaQuery.of(context).size.height *2/10)-50,
                            // decoration: BoxDecoration(
                            //   color: Colors.red[800],
                            //   borderRadius: BorderRadius.circular(dfltRadius),
                            // ),
                            child: OverflowBox(
                              maxHeight: MediaQuery.of(context).size.height *2/10,
                              child: Stack(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ///todo -> new animation restart and change screen
                                // SlideTransition(
                                //     position: _controllerSize.drive(Tween<Offset>(
                                //         begin: const Offset(0.0, -1.0),
                                //         end: const Offset(0.0, 2.0))),
                                //     child: Image(image: BlackJack.coverCard.image,
                                //       width:MediaQuery.of(context).size.width,)),
                                if(state.blackJack.listPlayer.length > 1)...[
                                  playersView(state.blackJack.listPlayer.length),
                                ],

                          Center(
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
                                
                                if(isVisibleFinalButton)...[
                                  ScaleTransition(
                                    scale: _controllerSize.drive(Tween(begin: 3.0, end: 1.0)),
                                    child: FadeTransition(
                                      opacity: _controllerSize.drive(Tween(begin: 0.0, end: 1.0)),
                                      child: SlideTransition(
                                        position: _controllerSize.drive(Tween(
                                            begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0))),
                                        child: Center(
                                          child: PanelBlurWidget(
                                            padding: 10,
                                            color: clrPlayer[0],
                                            child: Center(
                                              child: Text(state.blackJack.get().result ?? '',
                                              style: sampleTS,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
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
                        PanelBlurWidget(
                          padding: 2,
                          child: SlideTransition(
                            position: _controllerSize.drive(Tween(
                                begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if(isVisibleButton)...[
                                  HitButton( label: "Hit",
                                    color: Colors.brown,//brown[300]
                                  execute: () {
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
                                ),
                                  HitButton( label:"Stand",
                                    color: Colors.amber,
                                    execute: () {
                                      _controller.forward().whenComplete(() {
                                        context.read<JackCubit>().stand();
                                        context.read<CoinBloc>().add(
                                            FinishGame(state.blackJack.get().result,
                                                state.blackJack.listPlayer.length + 1));
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

                                  ),
                                ],
                                if(isVisibleFinalButton)...[
                                  HitButton(label:"Start",
                                    color: Colors.amber,
                                    execute:  (){
                                      _controller.forward().whenComplete(() {
                                        _controller.reverse().whenComplete(() {
                                          _controllerSize.reverse()
                                              .whenComplete(() {
                                            setState(() {
                                              isVisibleFinalButton = false;
                                              isVisibleButton = false;
                                            });
                                            Navigator.pushReplacementNamed(context, GameScreen.name);
                                          });
                                        });
                                      });
                                    },
                                  ),
                                  HitButton(label:"bet",
                                    color: clrPlayer[4],
                                    execute: (){
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) => BottomSheetSettings());
                                    },
                                  ),
                                  HitButton(label: "Score",
                                    color: Colors.deepOrange,
                                  execute: () {
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

                                ),],
                              ],
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

  Widget playersView(int length) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: length,
      itemBuilder: (context ,index) {
          return Align(
            alignment: FractionalOffset(
                0.9,
                0.5
            ),
            child: FadeTransition(
                opacity:
                _controller.drive(Tween(begin: 1.0, end: 0.0)),
                child: Image.asset(
                imgChip100, height: 25, color: clrPlayer[index],),
            ),
          );

      }
    );

  }


}
