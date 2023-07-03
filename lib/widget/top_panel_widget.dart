import 'package:black_jack/cubit/coin_bloc.dart';
import 'package:black_jack/widget/pannel_blure_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';

class TopPanelWidget extends StatelessWidget {
  const TopPanelWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinBloc, CoinState>(builder: (context, state) {
      return PanelBlurWidget(
        padding: 16.0,
        child: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            // direction: Axis.vertical,
            // crossAxisAlignment:
            // WrapCrossAlignment.center,
            children: [
              Container(
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      'Bet: ',
                      style: tsSample.copyWith(color: Colors.teal[800]),
                    ),
                    Text(
                      state.bet.toString(),
                      style: tsSample,
                    ),
                  ],
                ),
              ),
              // const Text(
              //   '21',
              //   style: tsLose,
              //   maxLines: 2,
              //   overflow: TextOverflow.fade,
              // ),
              Container(
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      'Coin: ',
                      style: tsSample.copyWith(color: Colors.teal[800]),
                    ),
                    Text(
                      state.coin.toString(),
                      style: tsSample,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}