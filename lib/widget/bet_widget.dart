import 'package:black_jack/widget/top_panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';
import '../cubit/coin_bloc.dart';

class BetWidget extends StatelessWidget {
  const BetWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinBloc, CoinState>(builder: (context, state) {
      return SizedBox(
        height: 200,
        child: Wrap(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Text(
            //       'coin: ${state.coin.toString()}',
            //       style: sampleTS,
            //     ),
            //     IconButton(
            //       onPressed: () {
            //         context.read<CoinBloc>().add(ChangeCoin(state.coin + 500));
            //       },
            //       icon: Icon(Icons.wind_power_sharp),
            //     ),
            //     Container(
            //       color: Colors.white,
            //       child: Text(
            //         'coin: ${state.bet.toString()}',
            //         style: loseTS,
            //       ),
            //     ),
            //     IconButton(
            //         onPressed: state.bet > 0
            //             ? () {
            //           context
            //               .read<CoinBloc>()
            //               .add(ChangeCoin(state.coin + state.bet));
            //           context.read<CoinBloc>().add(ChangeBet(0));
            //         }
            //             : null,
            //         icon: const Icon(Icons.close)),
            //
            //
            //   ],
            // ),
            TopPanelWidget(),
            Row(
              children: [
                MaterialButton(
                  onPressed: () {
                    context.read<CoinBloc>().add(ChangeCoin(state.coin + 10));
                    context.read<CoinBloc>().add(ChangeBet(state.bet - 10));
                  },
                  child: const Text("Remove", style: tsSample),
                  color: Colors.brown[300],
                ),
                MaterialButton(
                  onPressed: () {
                    context.read<CoinBloc>().add(ChangeCoin(state.coin - 10));
                    context.read<CoinBloc>().add(ChangeBet(state.bet + 10));
                  },
                  child: const Text("Insert", style: tsSample),
                  color: Colors.brown[300],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: state.coin >= 100
                  ? () {
                      context
                          .read<CoinBloc>()
                          .add(ChangeCoin(state.coin - 100));
                      context.read<CoinBloc>().add(ChangeBet(state.bet + 100));
                    }
                  : null,
              child: Image.asset(
                imgChip100,
                height: 50,
              ),
            ),
            ElevatedButton(
              onPressed: state.coin >= 300
                  ? () {
                      context
                          .read<CoinBloc>()
                          .add(ChangeCoin(state.coin - 300));
                      context.read<CoinBloc>().add(ChangeBet(state.bet + 300));
                    }
                  : null,
              child: Image.asset(
                imgChip300,
                height: 50,
              ),
            ),
            IconButton(
              onPressed: state.coin >= 500
                  ? () {
                      context
                          .read<CoinBloc>()
                          .add(ChangeCoin(state.coin - 500));
                      context.read<CoinBloc>().add(ChangeBet(state.bet + 500));
                    }
                  : null,
              icon: Image.asset(
                imgChip500,
                height: 50,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<CoinBloc>().add(ChangeCoin(state.coin + 500));
              },
              icon: Icon(Icons.wind_power_sharp),
            ),
            IconButton(
                onPressed: state.bet > 0
                    ? () {
                  context
                      .read<CoinBloc>()
                      .add(ChangeCoin(state.coin + state.bet));
                  context.read<CoinBloc>().add(ChangeBet(0));
                }
                    : null,
                icon: const Icon(Icons.close)),
          ],
        ),
      );
    });
  }
}
