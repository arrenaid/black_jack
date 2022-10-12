import 'package:black_jack/screens/game_screen.dart';
import 'package:flutter/material.dart';
import '../black_jack.dart';
import '../constants.dart';

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
      body: Center(
        child: Stack(
          children: [
            Align(
              alignment: const FractionalOffset(0.5, 0.8),
              child: MaterialButton(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 30),
                elevation: 15,
                onPressed: (){
                  _controller.forward().whenComplete((){
                    Navigator.pushReplacementNamed(context, GameScreen.name);
                  });
                },
                child:
                const Text("Start Black Jack", style: sampleTS),
                color: Colors.brown[300],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SlideTransition(
                  //alignment: _controller.drive(Tween(begin: Alignment.topCenter, end: Alignment.bottomCenter)),
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
