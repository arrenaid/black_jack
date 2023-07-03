import 'package:black_jack/widget/bottom_sheet_bet.dart';
import 'package:black_jack/widget/hit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../black_jack.dart';
import '../constants.dart';
import '../cubit/jack_cubit.dart';

class BottomSheetSettings extends StatelessWidget {
  const BottomSheetSettings({Key? key}) : super(key: key);

  static void show(BuildContext context) {
    showModalBottomSheet(
        context: context,
        elevation: 10,
        shape: shapeUpBorderRadius,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) => const BottomSheetSettings());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JackCubit, JackState>(
      builder: (context, state) {
        final BlackJackList game = state.blackJack;
        List<Player> players = [];
        players.add(game.dealer);
        players.addAll(game.listPlayer);
        final listClr = [];
        listClr.addAll(clrs);
        listClr.add(Colors.teal[200]);

        return Container(
          color: Colors.teal[100],
          height: MediaQuery.of(context).size.height / 2,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                height: MediaQuery.of(context).size.width / 6,
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.numberPlayers,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Image.asset(
                          imgChip100,
                          height: 25,
                          color: clrs[index],
                        ),
                      );
                    }),
              ),
              Container(
                height: 170,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                color: Colors.amber[200],
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Chip(
                      label: Text(
                        "Players: ${state.numberPlayers}",
                        style: tsBetOrange,
                      ),
                        backgroundColor: Colors.teal[900],
                    ),
                    Row(
                      children: [
                        HitButton(
                          execute: () {
                            context
                                .read<JackCubit>()
                                .changeNumberOfPlayers(--state.numberPlayers);
                          },
                          label: "Ban",
                          color: listClr[state.numberPlayers - 1],
                        ),
                        HitButton(
                          execute: () {
                            context
                                .read<JackCubit>()
                                .changeNumberOfPlayers(++state.numberPlayers);
                          },
                          label:"Insert",
                          color: listClr[state.numberPlayers] ,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                //width: MediaQuery.of(context).size.width ,
                height: 70,
                child: Row(
                  children: [
                    HitButton(
                        color: clrMrBlue,
                        execute: () => BottomSheetBet.show(context),
                        label: 'Change Bet'),
                    HitButton(
                        color: clrMrBlonde,
                        execute: () => Navigator.of(context).pop(),
                        label: 'OK'),
                  ],
                ),
              ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width,
              //   height: 70,
              //   child:
              // )
            ],
          ),
        );
      },
    );
  }
}
