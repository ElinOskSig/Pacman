import 'dart:async';
import 'dart:math';
import 'package:pacman/Villain.dart';
import 'package:flutter/material.dart';
import 'package:pacman/player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 17;
  int player = numberInRow * 4 + 5;
  int score = 0;
  int villain = numberInRow * 10 + 5;

  List<int> barriers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    88,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    175,
    164,
    153,
    142,
    131,
    120,
    109,
    98,
    87,
    76,
    65,
    54,
    43,
    32,
    21,
    89,
    100,
    122,
    133,
    97,
    108,
    130,
    141,
    24,
    25,
    29,
    30,
    16,
    27,
    38,
    59,
    60,
    61,
    57,
    63,
    71,
    82,
    46,
    52,
    102,
    103,
    105,
    106,
    113,
    117,
    124,
    125,
    126,
    127,
    128,
    68,
    74,
    137,
    156,
    157,
    148,
    159,
    161,
    162,
    136,
    138,
    70,
    72,
    111,
    119
  ];
  List<int> food = [];

  String direction = 'left';


  void playGame() {
    eatFood();
    Timer.periodic(Duration(milliseconds: 130), (timer) {
        if (food.contains(player)) {
          food.remove(player);
          score++;
        }
      switch (direction) {
        case "left":
          moveLeft();
          break;
        case "right":
          moveRight();
          break;
        case "up":
          moveUp();
          break;
        case "down":
          moveDown();
          break;
      }
    });
  }
    void eatFood() {
      for (int i = 0; i < numberOfSquares; i++) {
        if (!barriers.contains(i)) {
          food.add(i);
        }
      }
}
  void moveLeft() {
    if (!barriers.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }

  void moveRight() {
    if (!barriers.contains(player - 1)) {
      setState(() {
        player--;
      });
    }
  }

  void moveUp() {
    if (!barriers.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
      });
    }
  }

  void moveDown() {
    if (!barriers.contains(player + numberInRow)) {
      setState(() {
        player += numberInRow;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Score: ' + score.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: playGame,
                  child: Text(
                    'Play Game',
                    style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  direction = 'down';
                } else if (details.delta.dy < 0) {
                  direction = 'up';
                }
              },
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0) {
                    direction = 'left';
                  } else if (details.delta.dx < 0) {
                    direction = 'right';
                  }
                },
                child: Container(
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: numberOfSquares,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: numberInRow),
                    itemBuilder: (BuildContext context, int index) {
            if (villain == index) {
                    return Villain(
                    );
                    } else if (player == index) {
                        switch (direction) {
                          case "left":
                            return Player();
                            break;

                          case "right":
                            return Transform.rotate(
                              angle: pi,
                              child: Player(),
                            );
                            break;

                          case "up":
                            return Transform.rotate(
                              angle: pi / 2,
                              child: Player(),
                            );
                            break;

                          case "down":
                            return Transform.rotate(
                              angle: pi / 2,
                              child: Player(),
                            );
                            break;
                          default:
                            return Player();
                        }
                      } else if (barriers.contains(index)) {
                        return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                color: Colors.purple.shade700,
                              ),
                            ));
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
      ),
    );


  }
}
