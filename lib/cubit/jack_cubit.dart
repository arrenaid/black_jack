import 'package:black_jack/black_jack.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'jack_state.dart';

class JackCubit extends Cubit<JackState>{
  JackCubit() : super(JackState(status: JackStatus.initial,
      blackJack: BlackJack(), isFinish: false, score: 0));
  hit(){
    emit(state.copyWith(status: JackStatus.loading));
    state.blackJack.hitPlayer();
    emit(state.copyWith(status: JackStatus.loaded));
  }

  void stand() {
    emit(state.copyWith(status: JackStatus.loading));
    state.isFinish = true;
    state.blackJack.hitDealer();
    state.blackJack.winner();
    int resScore = state.score + state.blackJack.sessionScore;
    emit(state.copyWith(score:  resScore,status: JackStatus.loaded));
  }

}