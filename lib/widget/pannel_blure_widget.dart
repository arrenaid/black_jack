import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants.dart';

class PanelBlurWidget extends StatelessWidget {
  const PanelBlurWidget({Key? key, required this.child, required this.padding,
    this.color = Colors.white})
      : super(key: key);
  final Widget child;
  final double padding;
  final Color color;

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
            border: Border.all(color: color, width: 1.5),
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
