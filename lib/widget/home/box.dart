import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Box extends StatelessWidget {
  final String player;
  final double width;
  final double height;
  const Box(
      {super.key,
      required this.player,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(color: Colors.white30),
        margin: const EdgeInsets.all(10),
        child: Center(
          child: Text(player,
              style:
                  const TextStyle(fontSize: 42, fontWeight: FontWeight.bold)),
        ));
  }
}
