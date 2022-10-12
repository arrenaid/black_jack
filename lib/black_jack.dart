import 'dart:math';
import 'package:flutter/material.dart';

class Player {
  List<String> cards;
  int score;

  Player({required this.cards, required this.score});

  setScore(int score) {
    this.score = score;
  }
}

class BlackJack {
  final Map<String, int> deckOfCards = {
    "cards/2.1.png": 2,
    "cards/2.2.png": 2,
    "cards/2.3.png": 2,
    "cards/2.4.png": 2,
    "cards/3.1.png": 3,
    "cards/3.2.png": 3,
    "cards/3.3.png": 3,
    "cards/3.4.png": 3,
    "cards/4.1.png": 4,
    "cards/4.2.png": 4,
    "cards/4.3.png": 4,
    "cards/4.4.png": 4,
    "cards/5.1.png": 5,
    "cards/5.2.png": 5,
    "cards/5.3.png": 5,
    "cards/5.4.png": 5,
    "cards/6.1.png": 6,
    "cards/6.2.png": 6,
    "cards/6.3.png": 6,
    "cards/6.4.png": 6,
    "cards/7.1.png": 7,
    "cards/7.2.png": 7,
    "cards/7.3.png": 7,
    "cards/7.4.png": 7,
    "cards/8.1.png": 8,
    "cards/8.2.png": 8,
    "cards/8.3.png": 8,
    "cards/8.4.png": 8,
    "cards/9.1.png": 9,
    "cards/9.2.png": 9,
    "cards/9.3.png": 9,
    "cards/9.4.png": 9,
    "cards/10.1.png": 10,
    "cards/10.2.png": 10,
    "cards/10.3.png": 10,
    "cards/10.4.png": 10,
    "cards/J1.png": 10,
    "cards/J2.png": 10,
    "cards/J3.png": 10,
    "cards/J4.png": 10,
    "cards/Q1.png": 10,
    "cards/Q2.png": 10,
    "cards/Q3.png": 10,
    "cards/Q4.png": 10,
    "cards/K1.png": 10,
    "cards/K2.png": 10,
    "cards/K3.png": 10,
    "cards/K4.png": 10,
    "cards/A1.png": 11,
    "cards/A2.png": 11,
    "cards/A3.png": 11,
    "cards/A4.png": 11,
  };
  static Image coverCard = Image.asset("cards/cover.png");
  Map<String, int> _playingCards = {};
  int sessionScore = 0;
  Player dealer = Player(cards: [], score: 0);
  Player player = Player(cards: [], score: 0);

  init() {
    _playingCards = {};
    _playingCards.addAll(deckOfCards);
  }
  nextDealer(bool isFirst){
    dealer.cards.add(_addCart());
    if(!isFirst) dealer.setScore(deckOfCards[dealer.cards.last]!);
  }
  nextPlayer(){
    player.cards.add(_addCart());
    player.setScore(_updateScore(player));
  }
  BlackJack.empty(){
    init();
  }

  BlackJack() {
    try {
      init();
      dealer.cards.add(_addCart());
      dealer.cards.add(_addCart());
      player.cards.add(_addCart());
      player.cards.add(_addCart());
      player.setScore(_updateScore(player));
      dealer.setScore(deckOfCards[dealer.cards.last]!);
    } catch (e) {
      print(e);
    }
  }

  String _addCart() {
    Random random = Random();
    String card =
        _playingCards.keys.elementAt(random.nextInt(_playingCards.length));
    _playingCards.removeWhere((key, value) => key == card);
    return card;
  }

  int _updateScore(Player pl) {
    int result = 0;
    for (var element in pl.cards) {
      result += deckOfCards[element]!;
    }
    return result;
  }

  void hitPlayer() {
    player.cards.add(_addCart());
    player.setScore(_updateScore(player));
  }

  hitDealer() {
    dealer.setScore(_updateScore(dealer));
    while (dealer.score <= 14) {
      dealer.cards.add(_addCart());
      dealer.setScore(_updateScore(dealer));
    }
  }

  String winner() {
    String result =
        dealer.score == player.score || (dealer.score > 21 && player.score > 21)
            ? "Push!"
            : (dealer.score < player.score && player.score < 22) ||
                    (dealer.score > player.score && dealer.score > 21)
                ? "You Winner"
                : "Dealer Winner";
    if (result == "You Winner") {
      sessionScore += 300;
    } else {
      sessionScore -= 300;
    }
    if (player.score == 21) {
      result = "Black Jack";
      sessionScore += 1200;
    }
    return result;
  }
}
