import 'dart:math';
import 'package:flutter/material.dart';
// enum PlayerName { MrPink , MrWhite , MrOrange, MrBrown, MrBlue, MrBlonde }
class Player {
  List<String> cards;
  int score;
  late int sessionScore = 0;
  late String name;
  late String result;

  static final List<String> _nameList = [
    "MrPink" , "MrWhite" , "MrOrange", "MrBrown", "MrBlue", "MrBlonde"
  ];

  Player({required this.cards, required this.score, String? name }){
    if(name != null){this.name = name;}
  }

  setScore(int score) {
    this.score = score;
  }
}

class BlackJack {
  final Map<String, int> deckOfCards = {
    "assets/cards/2.1.png": 2,
    "assets/cards/2.2.png": 2,
    "assets/cards/2.3.png": 2,
    "assets/cards/2.4.png": 2,
    "assets/cards/3.1.png": 3,
    "assets/cards/3.2.png": 3,
    "assets/cards/3.3.png": 3,
    "assets/cards/3.4.png": 3,
    "assets/cards/4.1.png": 4,
    "assets/cards/4.2.png": 4,
    "assets/cards/4.3.png": 4,
    "assets/cards/4.4.png": 4,
    "assets/cards/5.1.png": 5,
    "assets/cards/5.2.png": 5,
    "assets/cards/5.3.png": 5,
    "assets/cards/5.4.png": 5,
    "assets/cards/6.1.png": 6,
    "assets/cards/6.2.png": 6,
    "assets/cards/6.3.png": 6,
    "assets/cards/6.4.png": 6,
    "assets/cards/7.1.png": 7,
    "assets/cards/7.2.png": 7,
    "assets/cards/7.3.png": 7,
    "assets/cards/7.4.png": 7,
    "assets/cards/8.1.png": 8,
    "assets/cards/8.2.png": 8,
    "assets/cards/8.3.png": 8,
    "assets/cards/8.4.png": 8,
    "assets/cards/9.1.png": 9,
    "assets/cards/9.2.png": 9,
    "assets/cards/9.3.png": 9,
    "assets/cards/9.4.png": 9,
    "assets/cards/10.1.png": 10,
    "assets/cards/10.2.png": 10,
    "assets/cards/10.3.png": 10,
    "assets/cards/10.4.png": 10,
    "assets/cards/J1.png": 10,
    "assets/cards/J2.png": 10,
    "assets/cards/J3.png": 10,
    "assets/cards/J4.png": 10,
    "assets/cards/Q1.png": 10,
    "assets/cards/Q2.png": 10,
    "assets/cards/Q3.png": 10,
    "assets/cards/Q4.png": 10,
    "assets/cards/K1.png": 10,
    "assets/cards/K2.png": 10,
    "assets/cards/K3.png": 10,
    "assets/cards/K4.png": 10,
    "assets/cards/A1.png": 11,
    "assets/cards/A2.png": 11,
    "assets/cards/A3.png": 11,
    "assets/cards/A4.png": 11,
  };
  static Image coverCard = Image.asset("assets/cards/cover.png");
  Map<String, int> _playingCards = {};


  init() {
    _playingCards = {};
    _playingCards.addAll(deckOfCards);
  }

  BlackJack() {
    init();
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

  Player hit(Player player) {
    player.cards.add(_addCart());
    player.setScore(_updateScore(player));
    return player;
  }

  Player next(Player player, bool isNotFirstDealer, bool isDealer){
    player.cards.add(_addCart());
    if(!isDealer) {
      player.setScore(_updateScore(player));
    }else if(isNotFirstDealer) {
      player.setScore(deckOfCards[player.cards.last]!);
    }
    return player;
  }

  Player dealerHit(Player dealer) {
    dealer.setScore(_updateScore(dealer));
    while (dealer.score <= 14) {
      dealer.cards.add(_addCart());
      dealer.setScore(_updateScore(dealer));
    }
    return dealer;
  }

  String finList(List<Player> players, Player dealer){
    int best = 0;
    Player winner;

    if(players.length > 1) {
      if(players[best].score > 21){
        for (int i = 1; i < players.length; i++) {
          if(players[i].score < 22){
            best = i;
            break;
          }
        }
      }
      for (int i = 1; i < players.length; i++) {
        if(i == best) continue;
        if (players[i].score > players[best].score && players[i].score < 22) {
          best = i;
        }
      }
    }
    players[best] = getResult(players[best], dealer);
    dealer = getResult(dealer, players[best]);
    winner = players[best].score > dealer.score ? players[best] : dealer;
    if(players.length > 1){
      for (int i = 0; i < players.length; i++) {
        if(i != best){
          players[i] = getResult(players[i], winner);
        }
      }
    }
    return winner.result;
  }

  Player getResult(Player player, Player dealer) {
    String result =
    dealer.score == player.score || (dealer.score > 21 && player.score > 21)
        ? "Push!"
        : (dealer.score < player.score && player.score < 22) ||
        (dealer.score > player.score && dealer.score > 21)
        ? "${player.name} Winner"
        : "Lose";
    if (result == "${player.name} Winner") {
      player.sessionScore += 300;
    } else {
      player.sessionScore -= 300;
    }
    if (player.score == 21) {
      result = "Black Jack";
      player.sessionScore += 1200;
    }
    player.result = result;
    return player;
  }

}
class BlackJackOne extends BlackJack{
  int sessionScore = 0;
  Player dealer = Player(cards: [], score: 0);
  Player player = Player(cards: [], score: 0);


  BlackJackOne.empty(){
    super.init();
  }
  nextDealer(bool isFirst){
    dealer = next(dealer, isFirst, true);
  }
  nextPlayer(){
    player = next(player, false, false);
  }

  void hitPlayer() {
    player = super.hit(player);
  }

  hitDealer() {
    dealer = dealerHit(dealer);
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


class BlackJackList extends BlackJack{
  List<Player> listPlayer = [];
  Player dealer = Player(cards: [], score: 0, name: "Dealer");
  int _lengthPlayer;
  late int _currentPlayer;

  init(){
    listPlayer = [];
    dealer = Player(cards: [], score: 0, name: "Dealer");
    while(listPlayer.length < _lengthPlayer){
      listPlayer.add(Player(cards: [], score: 0,
          name: Player._nameList[listPlayer.length]));
    }
  }
  BlackJackList( this._lengthPlayer){
    super.init();
    init();
    _currentPlayer = 0;
  }

  int get currentPlayer => _currentPlayer;

  set currentPlayer(int value) {
    _currentPlayer = value;
  }
  nextDealer(bool isFirst){
    dealer = next(dealer, isFirst, true);
  }
  nextPlayer(){
    listPlayer[_currentPlayer] = next(listPlayer[_currentPlayer], false, false);
    nextOther();
  }
  nextOther(){
    for(int i = _currentPlayer+1; i< listPlayer.length; i++) {
      listPlayer[i] = next(listPlayer[i], false, false);
    }
  }
  void hitPlayer() {
    listPlayer[_currentPlayer] = hit(listPlayer[_currentPlayer]);
  }
  hitDealer() {
    dealer = dealerHit(dealer);
    hitOther();
  }
  hitOther() {
    for(int i = _currentPlayer+1; i< listPlayer.length; i++) {
      listPlayer[i] = dealerHit(listPlayer[i]);
    }
  }
  String winner(){
    return finList(listPlayer, dealer);
  }
  Player get(){
    return listPlayer[_currentPlayer];
  }
}
