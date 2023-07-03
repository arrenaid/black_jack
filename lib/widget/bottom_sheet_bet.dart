import 'package:black_jack/constants.dart';
import 'package:black_jack/cubit/coin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'hit_button.dart';

class BottomSheetBet extends StatelessWidget {
  const BottomSheetBet({Key? key}) : super(key: key);

  static void show(BuildContext context) {
    showModalBottomSheet(
        context: context,
        elevation: 10,
        shape: shapeUpBorderRadius,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) => const BottomSheetBet());
  }

  @override
  Widget build(BuildContext context) {
    final values = [5, 10, 25, 100, 500, 3000];
    return BlocBuilder<CoinBloc, CoinState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
              height: MediaQuery.of(context).size.height * 2 / 3,
              decoration: BoxDecoration(
                color: Colors.teal[100],
                borderRadius: BorderRadius.circular(dfltRadius),
              ),
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                physics: const BouncingScrollPhysics(),
                children: [
                  //BET
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.bet.toString(),
                        style: tsBetOrange,
                      ),
                      if (state.bet > 0) ...[
                        IconButton(
                          onPressed: state.bet > 0
                              ? () {
                                  context
                                      .read<CoinBloc>()
                                      .add(ChangeCoin(state.coin + state.bet));
                                  context.read<CoinBloc>().add(ChangeBet(0));
                                }
                              : null,
                          icon: const Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 260,
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: values.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (state.coin >= values[index]) {
                              context
                                  .read<CoinBloc>()
                                  .add(ChangeCoin(state.coin - values[index]));
                              context
                                  .read<CoinBloc>()
                                  .add(ChangeBet(state.bet + values[index]));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                "all coin: ${state.coin}",
                                style: tsSample,
                              )));
                            }
                          },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: clrs[index],
                              borderRadius: BorderRadius.circular(dfltRadius),
                            ),
                            child: Center(
                              child: Text(
                                values[index].toString(),
                                style: tsSample,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  //Button
                  HitButton(
                    label: "Ok",
                    color: Colors.amber,
                    execute: () {
                      if (state.bet > 0) {
                        Navigator.of(context).pop();// todo решить что лучше анимация или быстрый доступ к игре
                        //Navigator.pushReplacementNamed(context, GameScreen.name);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            shape: shapeUpBorderRadius,
                            content: RichText(
                              text: TextSpan(
                                text: 'The ',
                                style: tsSample,
                                children: <TextSpan>[
                                  TextSpan(text: 'bet ',
                                      style: tsSample.copyWith(color: clrMrOrange)),
                                  const TextSpan(text: 'requires more than ',
                                      style: tsSample),
                                  TextSpan(text: 'zero',
                                      style: tsSample.copyWith(color: clrMrOrange)),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 5),
                ],
              ),
          ),
        );
      },
    );
  }
}
