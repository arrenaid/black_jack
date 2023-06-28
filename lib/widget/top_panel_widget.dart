import 'dart:ui';

import 'package:black_jack/cubit/coin_bloc.dart';
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
                      style: sampleTS.copyWith(color: Colors.teal[800]),
                    ),
                    Text(
                      state.bet.toString(),
                      style: sampleTS,
                    ),
                  ],
                ),
              ),
              Text(
                'BlackJack',
                style: loseTS,
              ),
              Container(
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      'Coin: ',
                      style: sampleTS.copyWith(color: Colors.teal[800]),
                    ),
                    Text(
                      state.coin.toString(),
                      style: sampleTS,
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

class PanelBlurWidget extends StatelessWidget {
  const PanelBlurWidget({Key? key, required this.child, required this.padding})
      : super(key: key);
  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 10,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Container(
          decoration: BoxDecoration(
            //color: Colors.red[800],
            borderRadius: BorderRadius.circular(dfltRadius),
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(dfltRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
