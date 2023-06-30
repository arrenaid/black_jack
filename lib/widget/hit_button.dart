import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants.dart';

class HitButton extends StatelessWidget {
  const HitButton(
      {Key? key,
      /*required this.controller,*/
      required this.color,
      required this.execute,
      required this.label})
      : super(key: key);

  /*final AnimationController controller;*/
  final Color color;
  final String label;
  final GestureTapCallback execute;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: execute,
          child: Text(
            label,
            style: sampleTS.copyWith(color: Colors.black),
          ),
          style: ButtonStyle(
            // fixedSize: MaterialStateProperty.all(
            //     Size(MediaQuery.of(context).size.width, 60)),
           //padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            minimumSize:  MaterialStateProperty.all(const Size(100,60)),
            elevation: MaterialStateProperty.all(2),
            backgroundColor: MaterialStateProperty.all(color),
            overlayColor: MaterialStateProperty.all(Colors.teal[800]),
              animationDuration: Duration(milliseconds: 5000),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            shadowColor: MaterialStateProperty.all(Colors.red),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(dfltRadius),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
