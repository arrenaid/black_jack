import 'package:black_jack/cubit/coin_bloc.dart';
import 'package:black_jack/screens/game_screen.dart';
import 'package:black_jack/widget/bottom_sheet_settings.dart';
import 'package:black_jack/widget/hit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../black_jack.dart';
import '../constants.dart';
import '../widget/bottom_sheet.dart';
import '../widget/bottom_sheet_bet.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);
  static const String name = "start_screen";

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      body: Center(
        child: Stack(
          children: [
            SlideTransition(
              position: _controller.drive(Tween<Offset>(
        begin: const Offset(0.0, 0.0),
          end: const Offset(0.0, 2.0))),
              child: Align(
              alignment: const FractionalOffset(0.5, 0.85),
              child: HitButton(
                execute: () => BottomSheetSettings.show(context),
                label: "SettingS",
                color: clrMrBlonde,
              ),
          ),
            ),
            SlideTransition(
              position: _controller.drive(Tween<Offset>(
                  begin: const Offset(0.0, 0.0),
                  end: const Offset(0.0, 2.0))),
              child: Align(
                alignment: const FractionalOffset(0.5, 0.8),
                child: HitButton(
                  execute: (){
                   if(context.read<CoinBloc>().state.bet > 0) {
                      _controller.forward().whenComplete(() {
                        Navigator.pushReplacementNamed(
                            context, GameScreen.name);
                      });
                    } else{
                     BottomSheetBet.show(context);
                   }
                  },
                  label: "Start Black Jack",
                  color: clrMrOrange,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SlideTransition(
                    position: _controller.drive(Tween<Offset>(
                        begin: const Offset(0.0, 0.0),
                        end: const Offset(0.0, 2.0))),
                    child: Image(image: BlackJack.coverCard.image)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
