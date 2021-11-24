import 'package:flutter/material.dart';
import 'dart:math';

class Background extends StatelessWidget {
  const Background({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          transform: GradientRotation(pi / 5),
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [
            0.2,
            0.4,
            0.5,
            0.7,
            0.9,
          ],
          colors: [
            Color(0xffbfa86e),
            Color(0xffac632c),
            Color(0xff9d2e32),
            Color(0xff66334f),
            Color(0xff2d3374),
          ],
        ),
      ),
      child: child,
    );
  }
}
