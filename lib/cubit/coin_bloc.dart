import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
part 'coin_event.dart';
part 'coin_state.dart';
const _coinKey = "COIN_KEY";

class CoinBloc extends Bloc<CoinEvent,CoinState>{
  CoinBloc() : super(const CoinState(0, 0, 0)){
   on<LoadCoin>(_onLoad);
   on<SaveCoin>(_onSave);
   on<ChangeCoin>(_onChangeCoin);
   on<ChangeBet>(_onChangeBet);
   on<ChangeTotal>(_onChangeTotal);
   on<FinishGame>(_onFinish);
  }
  _onFinish(FinishGame event, Emitter emit) {
    double value = state.coin as double;
    switch(event.result){
    case "Push!":
      value += state.bet / 2;
      break;
      case "You Winner":
        value += state.bet * event.index;
        break;
      case "Black Jack":
        value += state.bet * event.index;
        break;
      case "Dealer Winner":
        default:value -= state.bet;
    }
    int result = value as int;
    _setCoinSP(result.toString());
    emit(CoinState( result, state.bet, state.total));
  }
  _onLoad(LoadCoin event, Emitter emit) async {
    late int value;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? result = prefs.getString(_coinKey);
      value = int.parse(result!);
    } catch (e) {
      developer.log('Shared Preferences -> load', error: e);
      value = 0;
    }
    emit(CoinState(value, state.bet, state.total));
  }
  _onSave(SaveCoin event, Emitter emit) {
    _setCoinSP(state.coin.toString());
  }
  _onChangeBet(ChangeBet event, Emitter emit){
    emit(CoinState(state.coin ,event.value, state.total));
  }
  _onChangeCoin(ChangeCoin event, Emitter emit){
    emit(CoinState( event.value, state.bet, state.total));
  }
  _onChangeTotal(ChangeTotal event, Emitter emit) {
    emit(CoinState(state.coin ,state.bet, event.value));
  }
  _setCoinSP(String value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_coinKey, value);
    } catch (e) {
      developer.log('Shared Preferences -> save', error: e);
    }
  }
}