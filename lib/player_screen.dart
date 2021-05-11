import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerScreen extends StatefulWidget {
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final lst = List<String>.filled(9, "", growable: false);
  bool what = false;
  String ans = "";
  List toColor = [];
  String a = "", b = "", c = "";
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

  bool isPresent(int n) {
    for (int i = 0; i < toColor.length; i++) {
      if (toColor[i] == n) {
        return true;
      }
    }
    return false;
  }

  bool isO(String value) {
    if (value == "O") {
      return true;
    }
    return false;
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
              // height: availableHeight * 0.7,
              width: MediaQuery.of(context).size.width * 0.85,
              child: GridView.count(
                primary: false,
                // padding: const EdgeInsets.all(20 ),
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
                        setState(() {
                          lst[ind] = what ? 'O' : 'X';
                          what = !what;
                          ans = whoWins();
                          toColor = whoColor();
                        });
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
                          : Center(
                            child: Text(
                                entry.value,
                                style: TextStyle(
                                  fontSize: 80,
                                  color: isO(entry.value)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                          ),
                      style: ButtonStyle(
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
            SizedBox(
              height: availableHeight * 0.1,
            ),
            // if (allFilled() && ans == "")
            //   Container(
            //     child: Text("Tie"),
            //     height: availableHeight * 0.2,
            //   ), //tie
            // Container(
            //   child: Text(ans),
            //   height: availableHeight * 0.2,
            // ),
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
                  what = false; //game should always start with X
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


// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final lst = List<String>.filled(9, "", growable: false);

//   bool what = false;
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

//   @override
//   Widget build(BuildContext context) {
//     // printList();
//     return Column(
//       children: [
//         SizedBox(height: 5),
//         Container(
//           color: Colors.brown.shade600,
//           padding: EdgeInsets.all(0),
//           height: 410,
//           width: 410,
//           child: GridView.count(
//             primary: false,
//             // padding: const EdgeInsets.all(20),
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
//                     setState(() {
//                       lst[ind] = what ? 'O' : 'X';
//                       what = !what;
//                       ans = whoWins();
//                     });
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
//                   style: ButtonStyle(
//                       backgroundColor:
//                           MaterialStateProperty.all(Colors.red.shade400)),
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
//                 what = false; //game should always start with X
//               },
//               icon: Icon(Icons.restore))
//       ],
//     );
//   }
// }
