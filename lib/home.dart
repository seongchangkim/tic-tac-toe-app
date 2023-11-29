import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tic_tac_toe_app/widget/home/custom_ratio.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

enum ComputerDiffcult { easy, normal, hard }

class _HomeState extends State<Home> {
  ComputerDiffcult selectComputerDiffcult = ComputerDiffcult.easy;
  bool isStart = false;
  String currentPlayer = 'X';
  var boxes = [
    ['', '', ''],
    ['', '', ''],
    ['', '', '']
  ];

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
                  itemCount: boxes.length,
                  itemBuilder: ((BuildContext context, int i) {
                    return Container(
                        height: 130,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Center(
                            child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: boxes[i].length,
                          itemBuilder: ((BuildContext context, int j) {
                            return GestureDetector(
                              onTap: () => {
                                if (isStart)
                                  {
                                    setState(() {
                                      boxes[i][j] = currentPlayer;

                                      // X(자신) 승리
                                      if (checkWin('X')) {
                                        isStart = false;
                                        resetEvent();
                                        // O(AI) 승리
                                      } else if (checkWin('O')) {
                                        isStart = false;
                                        resetEvent();
                                        // 무승부
                                      } else if (checkDraw()) {
                                        isStart = false;
                                        resetEvent();
                                      }

                                      if (selectComputerDiffcult ==
                                          ComputerDiffcult.easy) {
                                        easyComputerMove();
                                      } else if (selectComputerDiffcult ==
                                          ComputerDiffcult.normal) {
                                        //
                                      } else if (selectComputerDiffcult ==
                                          ComputerDiffcult.hard) {
                                        //
                                      }
                                    })
                                  }
                              },
                              child: Container(
                                  height: 110,
                                  width: 110,
                                  decoration: const BoxDecoration(
                                      color: Colors.white30),
                                  margin: const EdgeInsets.all(10),
                                  child: Center(
                                    child: Text(boxes[i][j],
                                        style: const TextStyle(
                                            fontSize: 54,
                                            fontWeight: FontWeight.bold)),
                                  )),
                            );
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
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: [
                          CustomRatio(
                            height: _height * 0.05,
                            text: "쉬움",
                            func: () =>
                                setComputerDiffcultState(ComputerDiffcult.easy),
                            isActive:
                                selectComputerDiffcult == ComputerDiffcult.easy,
                            activeDecoration: const BoxDecoration(
                                color: Color.fromARGB(255, 2, 123, 211),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                          ),
                          CustomRatio(
                              height: _height * 0.05,
                              text: "보통",
                              func: () => setComputerDiffcultState(
                                  ComputerDiffcult.normal),
                              isActive: selectComputerDiffcult ==
                                  ComputerDiffcult.normal,
                              activeDecoration: const BoxDecoration(
                                color: Color.fromARGB(255, 2, 123, 211),
                              )),
                          CustomRatio(
                            height: _height * 0.05,
                            text: "어려움",
                            func: () =>
                                setComputerDiffcultState(ComputerDiffcult.hard),
                            isActive:
                                selectComputerDiffcult == ComputerDiffcult.hard,
                            activeDecoration: const BoxDecoration(
                                color: Color.fromARGB(255, 2, 123, 211),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => {
                  // 게임 시작 중이 아니면
                  if (!isStart)
                    {
                      setState(() => {isStart = true})
                    }
                  else
                    {resetEvent()}
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: isStart ? Colors.red : Colors.blue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0))),
                    width: _width * 0.3,
                    height: _height * 0.05,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Center(
                      child: Text(
                        isStart ? "다시 시작" : "시작",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )),
              )
            ]),
      ),
    );
  }

  // AI 난이도 선택 이벤트 메서드
  void setComputerDiffcultState(ComputerDiffcult diffcult) {
    setState(() => selectComputerDiffcult = diffcult);
  }

  // 리셋 이벤트 메서드
  void resetEvent() {
    setState(() {
      boxes = [
        ['', '', ''],
        ['', '', ''],
        ['', '', '']
      ];
    });
  }

  // 승리 조건 여부
  bool checkWin(String player) {
    for (int i = 0; i < boxes.length; i++) {
      // 가로 직선
      if (boxes[i][0] == player &&
          boxes[i][1] == player &&
          boxes[i][2] == player) return true;

      // 세로 직선
      if (boxes[0][i] == player &&
          boxes[1][i] == player &&
          boxes[2][i] == player) return true;
    }

    // 오른쪽 방향 대각선
    if (boxes[0][0] == player &&
        boxes[1][1] == player &&
        boxes[2][2] == player) {
      return true;
    }

    // 왼쪽 방향 대각선
    if (boxes[0][2] == player &&
        boxes[1][1] == player &&
        boxes[2][0] == player) {
      return true;
    }

    return false;
  }

  // 무승부 여부 체크
  bool checkDraw() {
    return boxes.every((row) => row.every((box) => box != ""));
  }

  // AI 난이도 쉬움 움직임
  void easyComputerMove() {
    bool computerChance = true;
    int rowIndex = 0;
    int colIndex = 0;
    var rng = Random();

    while (computerChance) {
      rowIndex = rng.nextInt(3);
      colIndex = rng.nextInt(3);

      if (boxes[rowIndex][colIndex] == '') {
        setState(() {
          boxes[rowIndex][colIndex] = 'O';
          computerChance = false;
        });
      }
    }
  }
}
