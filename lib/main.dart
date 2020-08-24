import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stone_paper_scissor/GameLogic.dart';

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
  int curCpuScore = 0;
  int curPlayerScore = 0;
  @override
  Widget build(BuildContext context) {
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
                curCpuScore = curPlayerScore = 0;
                currentgame.reset();
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
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: currentgame.getCpuhand(),
                  ),
                ),
              ),

              // SCORE BOARD
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
                  child: Row(children: <Widget>[
                    //CPU SIDE
                    Container(
                      color: Colors.blueGrey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: Colors.black,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 28.0, vertical: 4),
                              child: Text(
                                "CPU",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              "$curCpuScore",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      color: Colors.white,
                    ),

                    //player side
                    Container(
                      color: Colors.blueGrey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: Colors.black,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 28.0, vertical: 4),
                              child: Text(
                                "YOU",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "$curPlayerScore",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
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
                      radius: 70,
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

  Widget createbtn(int imageno) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Colors.white,
      child: FlatButton(
        shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
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
