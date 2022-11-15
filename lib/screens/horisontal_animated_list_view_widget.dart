import 'package:black_jack/cubit/jack_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../black_jack.dart';

class HorizontalListWidget extends StatefulWidget {
  HorizontalListWidget({
    required this.cards,
    required this.isDealer,
    required this.finish,
    required this.controller,
  });

  final List<String> cards;
  final bool isDealer;
  final bool finish;
  final AnimationController controller;

  @override
  State<HorizontalListWidget> createState() => _HorizontalListWidgetState();
}

class _HorizontalListWidgetState extends State<HorizontalListWidget> {
  late final AnimationController controller1;

  late List<String> imageList;
  final _listKey = GlobalKey<AnimatedListState>();

  // @override
  void initState() {
    imageList = [];
    super.initState();
  }
  bool update(List<String> items) {
    if (imageList.length == items.length) return true;
    for (var item in items) {
      if (false == imageList.contains(item)) {
        imageList.add(item);
        _listKey.currentState?.insertItem(imageList.length - 1);
        _listKey.currentState?.build(context);
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JackCubit, JackState>(
        buildWhen: (prevState, currentState) => (prevState != currentState && update(widget.isDealer
              ? currentState.blackJack.dealer.cards
              : currentState.blackJack.get().cards)),
        builder: (context, state) {
          update(widget.isDealer
            ? state.blackJack.dealer.cards
            : state.blackJack.get().cards);
          return Container(
            padding: EdgeInsets.only(left: 50.0),
            height: 250,
            alignment:
                widget.isDealer ? Alignment.bottomCenter : Alignment.topCenter,
            child: Stack(
              children: [
                AnimatedList(
                  key: _listKey,
                  initialItemCount: imageList.length,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index,
                      Animation<double> animation) {
                    return SlideTransition(
                      position: animation.drive(Tween(begin: Offset(1.0,-3.0), end:Offset(2.0, 0.0))),
                      child: ScaleTransition(
                        scale: animation.drive(Tween(begin: 3.8, end: 1)),
                        child: Transform.translate(
                          offset: Offset(0.0, index * 5),
                          child: Transform.scale(
                            scale: 3.8, //getScale(index),//3.8,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 2.0,
                              ),
                              //left:getPadding(state.blackJack.player.cards.length)
                              child: SizeTransition(
                                sizeFactor: animation,
                                child: widget.isDealer && index == 0 && !state.isFinish ?
                                Container(height: 50, child: BlackJack.coverCard)
                                : Container(
                                    height: 50, //getSize(index),
                                    child: Image.asset(imageList[index])),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        });
  }

  double getPadding(int index) {
    double result = 0;
    if (index <= 2) {
      result = 100; //50;
    }
    if (index == 3) {
      result = 50; //20;
    }
    if (index == 4) {
      result = 10;
    }
    if (index > 4) {
      result = 5;
    }
    return result;
  }

}