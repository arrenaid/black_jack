part of 'jack_cubit.dart';

enum JackStatus {initial, loaded, loading, error}

class JackState extends Equatable{
  JackStatus status;
  BlackJackList blackJack;
  bool isFinish;
  int score;
  int numberPlayers;
  JackState({
   required this.status,
   required this.blackJack,
   required this.isFinish,
   required this.score,
    required this.numberPlayers,
  });

  @override
  List<Object?> get props => [status, blackJack, isFinish, score, numberPlayers];

  copyWith({
    JackStatus? status,
    BlackJackList? blackJack,
    bool? isFinish,
    int? score,
    int? numberPlayers,
  }){
    return JackState(
        status: status ??  this.status,
        blackJack: blackJack ?? this.blackJack,
        isFinish: isFinish ?? this.isFinish,
        score: score ?? this.score,
        numberPlayers: numberPlayers ?? this.numberPlayers,
    );
  }
}