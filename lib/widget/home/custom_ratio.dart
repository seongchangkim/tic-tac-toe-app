import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomRatio extends StatelessWidget {
  final double height;
  final String text;
  final void Function() func;
  final bool isActive;
  final BoxDecoration activeDecoration;

  const CustomRatio(
      {super.key,
      required this.height,
      required this.text,
      required this.func,
      required this.isActive,
      required this.activeDecoration});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: func,
          child: Container(
            decoration: isActive ? activeDecoration : null,
            height: height,
            child: Center(
                child: Text(text,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold))),
          ),
        ));
  }
}
