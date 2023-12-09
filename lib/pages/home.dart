import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tic_tac_toe_app/dialog/home/game_over_alert_dialog.dart';
import 'package:tic_tac_toe_app/widget/home/box.dart';
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
    print("home height : ${_height}");

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
                        height: _height * 0.14,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Center(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: boxes[i].length,
                              itemBuilder: ((BuildContext context, int j) {
                                return GestureDetector(
                                    onTap: boxes[i][j] == ""
                                        ? () => {
                                              if (isStart)
                                                {
                                                  setState(() {
                                                    boxes[i][j] = currentPlayer;

                                                    // X(자신) 승리
                                                    if (checkWin('X')) {
                                                      resultEvent('승리',
                                                          '축하합니다! 당신이 AI를 이겼습니다.');
                                                      return;
                                                      // O(AI) 승리
                                                    } else if (checkWin('O')) {
                                                      resultEvent(
                                                          '패배', '아쉽네요. AI가 이겼습니다.');
                                                      return;
                                                      // 무승부
                                                    } else if (checkDraw()) {
                                                      resultEvent(
                                                          '무승부', '아쉽네요. 무승부입니다');
                                                      return;
                                                    }

                                                    if (selectComputerDiffcult ==
                                                        ComputerDiffcult.easy) {
                                                      easyComputerMove();
                                                    } else if (selectComputerDiffcult ==
                                                        ComputerDiffcult.normal) {
                                                      normalComputerMove();
                                                    } else if (selectComputerDiffcult ==
                                                        ComputerDiffcult.hard) {
                                                      hardComputerMove();
                                                    }

                                                    if (checkWin('O')) {
                                                      resultEvent(
                                                          '패배', '아쉽네요. AI가 이겼습니다.');
                                                      return;
                                                    }
                                                  })
                                                }
                                            }
                                        : null,
                                    child: Box(
                                      width: _width * 0.2,
                                      height: _height * 0.12,
                                      player: boxes[i][j]
                                    ));
                              }),
                            )));
                      })),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "AI 난이도 : ",
                      style: TextStyle(
                          fontFamily: 'PixelifySans',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: _width * 0.5,
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
                    width: _width * 0.35,
                    height: _height * 0.05,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Center(
                      child: Text(
                        isStart ? "다시 시작" : "시작",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
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

  // AI 쉬움 난이도 움직임
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

  // AI 보통 난이도
  void normalComputerMove() {
    // 승리 가능한 경우: 가로, 세로, 대각선 중 하나에서 승리 가능한 경우를 찾음.
    for (int i = 0; i < boxes.length; i++) {
      if (boxes[i][0] == 'O' && boxes[i][1] == 'O' && boxes[i][2] == '') {
        boxes[i][2] = 'O'; // 왼쪽에서 오른쪽으로 가로로 승리 가능
        return;
      }

      if (boxes[i][0] == 'O' && boxes[i][2] == 'O' && boxes[i][1] == '') {
        boxes[i][1] = 'O'; // 가운데에서 가로로 승리 가능
        return;
      }

      if (boxes[i][1] == 'O' && boxes[i][2] == 'O' && boxes[i][0] == '') {
        boxes[i][0] = 'O'; // 오른쪽에서 왼쪽으로 가로로 승리 가능
        return;
      }

      if (boxes[0][i] == 'O' && boxes[1][i] == 'O' && boxes[2][i] == '') {
        boxes[2][i] = 'O'; // 위에서 아래로 세로로 승리 가능
        return;
      }

      if (boxes[0][i] == 'O' && boxes[2][i] == 'O' && boxes[1][i] == '') {
        boxes[1][i] = 'O'; // 중앙에서 세로로 승리 가능
        return;
      }

      if (boxes[1][i] == 'O' && boxes[2][i] == 'O' && boxes[0][i] == '') {
        boxes[0][i] = 'O'; // 아래에서 위로 세로로 승리 가능
        return;
      }
    }

    // 상대방이 승리 가능한 경우 방지: 가로, 세로, 대각선 중 하나에서 상대방이 승리 가능한 경우를 방지함.
    for (int i = 0; i < boxes.length; i++) {
      if (boxes[i][0] == 'X' && boxes[i][1] == 'X' && boxes[i][2] == '') {
        boxes[i][2] = 'O';
        return;
      }

      if (boxes[i][0] == 'X' && boxes[i][2] == 'X' && boxes[i][1] == '') {
        boxes[i][1] = 'O';
        return;
      }

      if (boxes[i][1] == 'X' && boxes[i][2] == 'X' && boxes[i][0] == '') {
        boxes[i][0] = 'O';
        return;
      }

      if (boxes[0][i] == 'X' && boxes[1][i] == 'X' && boxes[2][i] == '') {
        boxes[2][i] = 'O';
        return;
      }

      if (boxes[0][i] == 'X' && boxes[2][i] == 'X' && boxes[1][i] == '') {
        boxes[1][i] = 'O';
        return;
      }

      if (boxes[1][i] == 'X' && boxes[2][i] == 'X' && boxes[0][i] == '') {
        boxes[0][i] = 'O';
        return;
      }
    }

    easyComputerMove();
  }

  // AI 어려움 난이도 움직임
  void hardComputerMove() {
    var bestMove = minimax('O');
    int rowIndex = bestMove['row'];
    int colIndex = bestMove['col'];

    setState(() {
      boxes[rowIndex][colIndex] = 'O';
    });
  }

  // 미니맥스 알고리즘을 이용하여 AI의 최적의 움직임을 게산하는 메소드
  minimax(String player) {
    if (checkWin('X')) {
      return {'row': 0, 'col': 0, 'score': -1};
    } else if (checkWin('O')) {
      return {'row': 0, 'col': 0, 'score': 1};
    } else if (checkDraw()) {
      return {'row': 0, 'col': 0, 'score': 0};
    }

    var moves = [];
    var subBoxes = boxes;
    for (int row = 0; row < boxes.length; row++) {
      for (int col = 0; col < boxes[row].length; col++) {
        if (boxes[row][col] == '') {
          boxes[row][col] = player;
          var move = {
            'row': row,
            'col': col,
            'score': minimax(player == 'X' ? 'O' : 'X')['score']
          };
          moves.add(move);
          subBoxes[row][col] = '';
        }
      }
    }

    var bestMove;
    if (player == 'O') {
      int bestScore = -double.maxFinite.toInt();
      for (var move in moves) {
        if (move['score'] > bestScore) {
          bestScore = move['score'];
          bestMove = move;
        }
      }
    } else {
      int bestScore = double.maxFinite.toInt();
      for (var move in moves) {
        if (move['score'] < bestScore) {
          bestScore = move['score'];
          bestMove = move;
        }
      }
    }

    return bestMove;
  }

  void resultEvent(String title, String content) {
    isStart = false;
    resetEvent();
    showDialog(
        context: context,
        builder: ((context) {
          return GameOverAlertDialog(title: title, content: content);
        }));
  }
}
