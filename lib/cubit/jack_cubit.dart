import 'package:black_jack/black_jack.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'jack_state.dart';

class JackCubit extends Cubit<JackState>{
  JackCubit() : super(JackState(status: JackStatus.initial,
      blackJack: BlackJackList(1), isFinish: false, score: 0,numberPlayers: 1));
  void restart(){
    emit(state.copyWith(status: JackStatus.initial,
      blackJack:BlackJackList(state.numberPlayers),// BlackJackOne.empty(),
      isFinish: false,
    ));
  }
  void dealer(){
    emit(state.copyWith(status: JackStatus.loading));
    state.blackJack.nextDealer(state.blackJack.dealer.cards.isNotEmpty);
    emit(state.copyWith(status: JackStatus.loaded));
  }
  void player(){
    emit(state.copyWith(status: JackStatus.loading));
    state.blackJack.nextPlayer();
    emit(state.copyWith(status: JackStatus.loaded));
  }

  void hit(){
    emit(state.copyWith(status: JackStatus.loading));
    state.blackJack.hitPlayer();
    emit(state.copyWith(status: JackStatus.loaded));
  }

  void stand() {
    emit(state.copyWith(status: JackStatus.loading));
    state.isFinish = true;
    state.blackJack.hitDealer();
    state.blackJack.winner();
    int resScore = state.score + state.blackJack.listPlayer[0].sessionScore;//state.blackJack.sessionScore;
    emit(state.copyWith(score:  resScore,status: JackStatus.loaded));
  }
  void changeNumberOfPlayers(int value){
    emit(state.copyWith(status: JackStatus.loading));
    if(value < 1 ) value = 1;
    if(value > 6) value = 6;
    emit(state.copyWith(status: JackStatus.loaded, numberPlayers: value));
  }
}
