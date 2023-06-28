part of 'coin_bloc.dart';

class CoinState extends Equatable{
  final int coin;
  final int bet;
  final double total;

  const CoinState(this.coin, this.bet, this.total);

  @override
  List<Object?> get props => [coin, bet, total];

}