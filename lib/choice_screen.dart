import 'package:bestxo/bot_screen.dart';
import 'package:flutter/material.dart';
import 'package:bestxo/player_screen.dart';

class ChoiceScreen extends StatelessWidget {
  void onPlayerScreenSelected(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return PlayerScreen();
        },
      ),
    );
  }

  void onBotScreenSelected(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return BotScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Colors.red.shade900.withOpacity(0.9),
      title: Text("XOXO"),
    );

    var availableHeight = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: availableHeight * 0.2,
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                width: MediaQuery.of(context).size.width * 0.9,
              ),
              child: ElevatedButton(
                onPressed: () => onPlayerScreenSelected(context),
                child: Text("2x Player"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red.shade400,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w200)),
              ),
            ),
            SizedBox(
              height: availableHeight * 0.05,
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                width: MediaQuery.of(context).size.width * 0.9,
              ),
              child: ElevatedButton(
                onPressed: () => onBotScreenSelected(context),
                child: Text("Play with Bot"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red.shade400,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w200)),
              ),
            ),
            SizedBox(
              height: availableHeight * 0.05,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              color: Colors.red.shade100.withOpacity(0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/icons8-bull-96.png"),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.warning_rounded,
                            color: Colors.red,
                          ),
                          disabledColor: Colors.red,
                        ),
                        Text(
                          "You can't BEAT the BOT!",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: availableHeight * 0.2,
            ),
          ],
        ),
      ),
    );
  }
}
