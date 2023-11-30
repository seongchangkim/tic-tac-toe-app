import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GameOverAlertDialog extends StatelessWidget {
  final String title;
  final String content;

  const GameOverAlertDialog(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;

    return Dialog(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: _width * 0.5,
        height: _height * 0.25,
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black, width: 1.0))),
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                )),
            Expanded(
                flex: 3,
                child: Container(
                  child: Center(
                    child: Text(content),
                  ),
                )),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.black, width: 1.0))),
                    child: const Center(
                      child: Text(
                        "확인",
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
