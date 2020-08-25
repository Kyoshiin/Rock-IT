import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stone_paper_scissor/GameLogic.dart';
import 'package:audioplayers/audio_cache.dart';

GameLogic currentgame = GameLogic();

void main() => runApp(Stone());

class Stone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(home: GamePage());
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double height, width;
  final player = AudioCache();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Rock It"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
              size: 26,
            ),
            onPressed: () {
              setState(() {
                currentgame.reset();
                player.play('clean.mp3');
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bck.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // CPU HAND
              Expanded(
                flex: 2,
                child: CircleAvatar(
                  radius: 0.16 * width,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: currentgame.getCpuhand(),
                  ),
                ),
              ),

              // SCORE BOARD
              Padding(
                padding: EdgeInsets.fromLTRB(0.26 * width, 0, 0, 0),
                child: Row(children: <Widget>[
                  //CPU SIDE
                  buildScoreBoard("CPU", currentgame.getCpuScore()),

                  Container(
                    width: 1,
                  ),

                  //player side
                  buildScoreBoard("YOU", currentgame.getPlayerScore())
                ]),
              ),

              //PLAYER'S HAND
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 0.17 * width,
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
          ),
        ),
      ),
    );
  }

  Widget buildScoreBoard(String nm, int score) {
    return Container(
      color: Colors.blueGrey,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 0.07 * width, vertical: 0.005 * height),
              child: Text(
                nm,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 0.025 * height,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.02 * height),
            child: Text(
              "$score",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 0.05 * height,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget createbtn(int imageno) {
    return CircleAvatar(
      radius: 0.1 * width,
      backgroundColor: Colors.white,
      child: FlatButton(
        shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
        child: Image.asset("images/$imageno.png"),
        onPressed: () {
          setState(
            () {
              currentgame.setHand(imageno);
              player.play('tap.wav');
            },
          );
        },
      ),
    );
  }
}
