part of 'jack_cubit.dart';

enum JackStatus {initial, loaded, loading, error}

class JackState extends Equatable{
  JackStatus status;
  BlackJack blackJack;
  bool isFinish;
  int score;
  JackState({
   required this.status,
   required this.blackJack,
   required this.isFinish,
   required this.score
  });

  @override
  List<Object?> get props => [status, blackJack, isFinish, score];

  copyWith({
    JackStatus? status,
    BlackJack? blackJack,
    bool? isFinish,
    int? score,
  }){
    return JackState(
        status: status ??  this.status,
        blackJack: blackJack ?? this.blackJack,
        isFinish: isFinish ?? this.isFinish,
        score: score ?? this.score);
  }
}