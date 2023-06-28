part of 'coin_bloc.dart';

abstract class CoinEvent extends Equatable{}
class LoadCoin extends CoinEvent{
  @override
  List<Object?> get props => [];
}
class SaveCoin extends CoinEvent{
  @override
  List<Object?> get props => [];
}
class ChangeCoin extends CoinEvent{
  final int value;
  ChangeCoin(this.value);
  @override
  List<Object?> get props => [value];
}
class ChangeBet extends CoinEvent{
  final int value;
  ChangeBet(this.value);
  @override
  List<Object?> get props => [value];
}
class ChangeTotal extends CoinEvent{
  final double value;
  ChangeTotal(this.value);
  @override
  List<Object?> get props => [value];
}
class FinishGame extends CoinEvent{
  final String result;
  final int index;
  FinishGame(this.result, this.index);
  @override
  List<Object?> get props => [result,index];
}