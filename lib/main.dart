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
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text("Rock It"),
        ),
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GamePage(),
          ),
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
        Expanded(
          flex: 2,
          child: CircleAvatar(
            radius: 80,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: currentgame.getCpuhand(),
            ),
          ),
        ),

        // SCORE BOARD
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              "CPU - YOU\n$curCpuScore   -   $curPlayerScore",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
        ),

        //PLAYER'S HAND
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 80,
                child: ClipOval(
                  child: currentgame.getPlayerhand(),
                ),
              ),
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
        ),
      ],
    );
  }

  Widget createbtn(int imageno) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.white,
      child: FlatButton(
        child: Image.asset("images/$imageno.png"),
        onPressed: () {
          setState(
            () {
              currentgame.setHand(imageno);
              curCpuScore = currentgame.getCpuScore();
              curPlayerScore = currentgame.getPlayerScore();
            },
          );
        },
      ),
    );
  }
}
