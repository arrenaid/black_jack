import 'package:black_jack/black_jack.dart';
import 'package:flutter/material.dart';

class CardsGridView extends StatelessWidget {
  CardsGridView({
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
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      alignment: isDealer ? Alignment.bottomCenter : Alignment.topCenter,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cards.length < 4 ? cards.length : 3,
          ),
          physics: cards.length < 7
              ? NeverScrollableScrollPhysics()
              : BouncingScrollPhysics(),
          itemCount: cards.length,
          clipBehavior: Clip.none,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return isDealer && index == 0 && !finish
                ? Container(height: 50, child: BlackJack.coverCard)
                : cards[index] == cards.last ? SlideTransition(
                    position: isDealer
                        ? controller.drive(Tween<Offset>(
                            begin: const Offset(0.0, 0.0),
                            end: const Offset(0.0, -1.0)))
                        : controller.drive(Tween<Offset>(
                            begin: const Offset(0.0, 0.0),
                            end: const Offset(0.0, 1.0))),
                    child: FadeTransition(
                        opacity: controller.drive(Tween(begin: 1.0, end: 0.0)),
                        child: Container(
                            height: 50, child: Image.asset(cards[index]))),
                  )
                : Container(
                height: 50, child: Image.asset(cards[index]));
          }),
    );
  }
}
