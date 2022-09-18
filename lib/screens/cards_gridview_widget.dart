import 'package:black_jack/black_jack.dart';
import 'package:flutter/material.dart';

class CardsGridView extends StatelessWidget {
  CardsGridView({
    required this.cards, required this.isDealer, required this.finish,
  });
  final List<String> cards;
  final bool isDealer;
  final bool finish;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      alignment: isDealer ? Alignment.bottomCenter: Alignment.topCenter,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cards.length < 4 ?cards.length: 3,
          ),
          physics:cards.length < 7 ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
          itemCount: cards.length,
          clipBehavior: Clip.none,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return isDealer && index == 0 && !finish
                ? Container( height: 50, child: BlackJack.coverCard)
                : Container( height: 50, child: Image.asset(cards[index]));
          }),
    );
  }
}
