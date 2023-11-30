import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Box extends StatelessWidget {
  final String player;
  const Box({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 110,
        width: 110,
        decoration: const BoxDecoration(color: Colors.white30),
        margin: const EdgeInsets.all(10),
        child: Center(
          child: Text(player,
              style:
                  const TextStyle(fontSize: 54, fontWeight: FontWeight.bold)),
        ));
  }
}
