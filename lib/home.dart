import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String computerDiffcult = "쉬움";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;

    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        decoration:
            const BoxDecoration(color: Color.fromRGBO(100, 116, 139, 1)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: const Text(
                  "Tic-Tac-Toe",
                  style: TextStyle(
                      fontFamily: 'PixelifySans',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: ((context, index) {
                    return Container(
                        height: 130,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Center(
                            child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: ((BuildContext context, int index) {
                            return Container(
                                height: 110,
                                width: 110,
                                decoration:
                                    const BoxDecoration(color: Colors.white30),
                                margin: const EdgeInsets.all(10),
                                child: const Text(""));
                          }),
                        )));
                  })),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("AI 난이도 : "),
                    Container(
                      width: _width * 0.4,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      // padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () => {},
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 2, 123, 221),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  )
                                ),
                                height: _height * 0.05,
                                child: const Center(
                                  child: Text(
                                    "쉬움",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold
                                    )
                                  )
                                ),
                              ),
                            )
                            
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () => {},
                              child: Container(
                                height: _height * 0.05,
                                child: const Center(
                                  child: Text(
                                    "보통",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold
                                    )
                                  )
                                ),
                              ),
                            )
                            
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () => {},
                              child: Container(
                                height: _height * 0.05,
                                child: const Center(
                                  child: Text(
                                    "어려움",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold
                                    )
                                  )
                                ),
                              ),
                            )
                            
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  width: _width * 0.3,
                  height: _height * 0.05,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: const Center(
                    child: Text(
                      "시작",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ))
            ]),
      ),
    );
  }
}
