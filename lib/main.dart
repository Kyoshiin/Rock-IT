import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stone_paper_scissor/GameLogic.dart';

GameLogic currentgame = GameLogic();

void main() => runApp(Stone());

class Stone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green[400],
        body: SafeArea(
          child: GamePage(),
        ),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int curCpuScore = 0;
  int curPlayerScore = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // CPU HAND
        Center(
          child: currentgame.getCpuhand(),
        ),

        // SCORE BOARD
        Padding(
          padding: EdgeInsets.symmetric(vertical: 70, horizontal: 0),
          child: Center(
            child: Text(
              "CPU - YOU\n$curCpuScore   -   $curPlayerScore",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),

        //PLAYER'S HAND
        Column(
          children: <Widget>[
            Center(
              child: currentgame.getPlayerhand(),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                createbtn(1),
                createbtn(2),
                createbtn(3),
              ],
            )
          ],
        ),
      ],
    );
  }

  FlatButton createbtn(int imageno) {
    return FlatButton(
      child: Image.asset("images/$imageno.png", height: 100, width: 80),
      onPressed: () {
        setState(
          () {
            currentgame.setHand(imageno);
            curCpuScore = currentgame.getCpuScore();
            curPlayerScore = currentgame.getPlayerScore();
          },
        );
      },
    );
  }
}
