import 'dart:math';

import 'package:flutter/material.dart';

class BotScreen extends StatefulWidget {
  @override
  _BotScreenState createState() => _BotScreenState();
}

class _BotScreenState extends State<BotScreen> {
  final lst = List<String>.filled(9, "", growable: false);

  bool botsTurn = false;
  String ans = "";
  List toColor = [];

  String whoWins() {
    for (int i = 0; i < 7; i += 3) {
      if (lst[i] == lst[i + 1] && lst[i + 1] == lst[i + 2] && lst[i] != "") {
        return lst[i];
      }
    }
    for (int i = 0; i < 3; i++) {
      if (lst[i] == lst[i + 3] && lst[i + 3] == lst[i + 6] && lst[i] != "") {
        return lst[i];
      }
    }
    if (lst[0] == lst[4] && lst[4] == lst[8] && lst[0] != "") {
      return lst[0];
    }
    if (lst[2] == lst[4] && lst[4] == lst[6] && lst[2] != "") {
      return lst[2];
    }
    return "";
  }

  List whoColor() {
    List l = [];

    for (int i = 0; i < 7; i += 3) {
      if (lst[i] == lst[i + 1] && lst[i + 1] == lst[i + 2] && lst[i] != "") {
        l.add(i);
        l.add(i + 1);
        l.add(i + 2);
        return l;
      }
    }
    for (int i = 0; i < 3; i++) {
      if (lst[i] == lst[i + 3] && lst[i + 3] == lst[i + 6] && lst[i] != "") {
        l.add(i);
        l.add(i + 3);
        l.add(i + 6);
        return l;
      }
    }
    if (lst[0] == lst[4] && lst[4] == lst[8] && lst[0] != "") {
      l.add(0);
      l.add(4);
      l.add(8);
      return l;
    }
    if (lst[2] == lst[4] && lst[4] == lst[6] && lst[2] != "") {
      l.add(2);
      l.add(4);
      l.add(6);
      return l;
    }

    return l;
  }

  bool allFilled() {
    for (int i = 0; i < 9; i++) {
      if (lst[i] == "") {
        return false;
      }
    }
    return true;
  }

  bool isO(String value) {
    if (value == "O") {
      return true;
    }
    return false;
  }

  bool isPresent(int n) {
    for (int i = 0; i < toColor.length; i++) {
      if (toColor[i] == n) {
        return true;
      }
    }
    return false;
  }

  var scores = {'X': 1, 'O': -1, "": 0};

  int minimax(int depth, bool isMaximizing) {
    var winner = whoWins();
    if (winner == "" && allFilled()) { // tie
      return 0;
    }
    if (winner == 'X') {
      return -1;
    }
    if (winner == 'O') {
      return 1;
    }

    if (isMaximizing) {
      var bestScore = -999999999;
      for (int i = 0; i < 9; i++) {
        if (lst[i] == "") {
          lst[i] = 'O';
          var score = minimax(depth + 1, false);
          lst[i] = "";
          bestScore = max(bestScore, score);
        }
      }
      return bestScore;
    } else {
      var bestScore = 999999999;
      for (int i = 0; i < 9; i++) {
        if (lst[i] == "") {
          lst[i] = 'X';
          var score = minimax(depth + 1, true);
          lst[i] = "";
          bestScore = min(bestScore, score);
        }
      }
      return bestScore;
    }
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Colors.red.shade900.withOpacity(0.6),
      title: Text("XOXO"),
    );

    var availableHeight = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);

    return Scaffold(
      backgroundColor: Colors.red.shade400,
      appBar: appBar,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: availableHeight * 0.05,
            ),
            Container(
              color: Colors.red.shade900.withOpacity(0.6),
              padding: EdgeInsets.all(0),
              // height: 410,
              width: MediaQuery.of(context).size.width * 0.85,
              child: GridView.count(
                primary: false,
                // padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                children: lst.asMap().entries.map(
                  (entry) {
                    int ind = entry.key;
                    return ElevatedButton(
                      onPressed: () {
                        if (entry.value != "") {
                          return;
                        }

                        if (!botsTurn) {
                          setState(() {
                            lst[ind] = 'X';
                            ans = whoWins();
                            if (!allFilled()) {
                              botsTurn = true;
                            }
                          });
                        }

                        if (botsTurn) {
                          var bestScore = -999999999;
                          int move = 0;
                          for (int i = 0; i < 9; i++) {
                            if (lst[i] == "") {
                              lst[i] = 'O';
                              var score = minimax(0, false);
                              lst[i] = "";
                              if (score > bestScore) {
                                bestScore = score;
                                move = i;
                              }
                            }
                          }
                          setState(() {
                            lst[move] = 'O';
                            ans = whoWins();
                            botsTurn = false;
                          });
                        }
                        //To make buttons unclicable after any player wins
                        if (ans != "") {
                          toColor = whoColor();
                          for (int i = 0; i < 9; i++) {
                            if (lst[i] == "") {
                              lst[i] = "Avni";
                            }
                          }
                        }
                      },
                      child: entry.value == "Avni"
                          ? Text("")
                          : Text(
                              entry.value,
                              style: TextStyle(
                                fontSize: 80,
                                color: isO(entry.value)
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.fromLTRB(0, 0, 0, 10),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.red.shade400),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            isPresent(ind)
                                ? Colors.red.shade900.withOpacity(0.6)
                                : Colors.red.shade400),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            // if (allFilled() && ans == "") Text("Tie"), //tie
            // Text(ans),
            SizedBox(
              height: availableHeight * 0.1,
            ),
            if (ans == "X" || ans == "O" || allFilled())
              IconButton(
                onPressed: () {
                  toColor.clear();
                  for (int i = 0; i < 9; i++) {
                    lst[i] = "";
                  }
                  setState(() {
                    ans = "";
                  });
                  botsTurn = false; //game should always start with X
                },
                icon: Icon(Icons.restore),
                iconSize: 50,
                color: Colors.white,
                splashColor: Colors.black,
              ),
            SizedBox(
              height: availableHeight * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}




// class MyHomeBotPage extends StatefulWidget {
//   @override
//   _MyHomeBotPageState createState() => _MyHomeBotPageState();
// }

// class _MyHomeBotPageState extends State<MyHomeBotPage> {
//   final lst = List<String>.filled(9, "", growable: false);

//   bool botsTurn = false;
//   String ans = "";

//   String whoWins() {
//     for (int i = 0; i < 7; i += 3) {
//       if (lst[i] == lst[i + 1] && lst[i + 1] == lst[i + 2]) {
//         return lst[i];
//       }
//     }
//     for (int i = 0; i < 3; i++) {
//       if (lst[i] == lst[i + 3] && lst[i + 3] == lst[i + 6]) {
//         return lst[i];
//       }
//     }
//     if (lst[0] == lst[4] && lst[4] == lst[8]) {
//       return lst[0];
//     }
//     if (lst[2] == lst[4] && lst[4] == lst[6]) {
//       return lst[2];
//     }
//     return "";
//   }

//   bool allFilled() {
//     for (int i = 0; i < 9; i++) {
//       if (lst[i] == "") {
//         return false;
//       }
//     }
//     return true;
//   }

//   var scores = {'X': 1, 'O': -1, "": 0};

//   int minimax(int depth, bool isMaximizing) {
//     var winner = whoWins();
//     if (winner == "" && allFilled()) {
//       return 0;
//     }
//     if (winner == 'X') {
//       return -1;
//     }
//     if (winner == 'O') {
//       return 1;
//     }

//     if (isMaximizing) {
//       var bestScore = -999999999;
//       for (int i = 0; i < 9; i++) {
//         if (lst[i] == "") {
//           lst[i] = 'O';
//           var score = minimax(depth + 1, false);
//           lst[i] = "";
//           bestScore = max(bestScore, score);
//         }
//       }
//       return bestScore;
//     } else {
//       var bestScore = 999999999;
//       for (int i = 0; i < 9; i++) {
//         if (lst[i] == "") {
//           lst[i] = 'X';
//           var score = minimax(depth + 1, true);
//           lst[i] = "";
//           bestScore = min(bestScore, score);
//         }
//       }
//       return bestScore;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(botsTurn ? "O" : "X"),
//         SizedBox(height: 5),
//         Container(
//           color: Colors.red,
//           padding: EdgeInsets.all(0),
//           height: 410,
//           width: 410,
//           child: GridView.count(
//             primary: false,
//             padding: const EdgeInsets.all(20),
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//             crossAxisCount: 3,
//             children: lst.asMap().entries.map(
//               (entry) {
//                 int ind = entry.key;
//                 return ElevatedButton(
//                   onPressed: () {
//                     if (entry.value != "") {
//                       return;
//                     }

//                     if (!botsTurn) {
//                       setState(() {
//                         lst[ind] = 'X';
//                         ans = whoWins();
//                         if (!allFilled()) {
//                           botsTurn = true;
//                         }
//                       });
//                     }

//                     if (botsTurn) {
//                       var bestScore = -999999999;
//                       int move = 0;
//                       for (int i = 0; i < 9; i++) {
//                         if (lst[i] == "") {
//                           lst[i] = 'O';
//                           var score = minimax(0, false);
//                           lst[i] = "";
//                           if (score > bestScore) {
//                             bestScore = score;
//                             move = i;
//                           }
//                         }
//                       }
//                       setState(() {
//                         lst[move] = 'O';
//                         ans = whoWins();
//                         botsTurn = false;
//                       });
//                     }
//                     //To make buttons unclicable after any player wins
//                     if (ans != "") {
//                       for (int i = 0; i < 9; i++) {
//                         if (lst[i] == "") {
//                           lst[i] = "Avni";
//                         }
//                       }
//                     }
//                   },
//                   child: entry.value == "Avni" ? Text("") : Text(entry.value),
                  
//                 );
//               },
//             ).toList(),
//           ),
//         ),
//         if (allFilled() && ans == "") Text("Tie"), //tie
//         Text(ans),
//         if (ans == "X" || ans == "O" || allFilled())
//           IconButton(
//               onPressed: () {
//                 for (int i = 0; i < 9; i++) {
//                   lst[i] = "";
//                 }
//                 setState(() {
//                   ans = "";
//                 });
//                 botsTurn = false; //game should always start with X
//               },
//               icon: Icon(Icons.restore))
//       ],
//     );
//   }
// }
