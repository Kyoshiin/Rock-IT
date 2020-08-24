import 'dart:math';

import 'package:flutter/cupertino.dart';

class GameLogic {
  int _cpuhand = 1;
  int _playerhand = 1;

  int _cpuScore = 0;
  int _playerScore = 0;

  Image getCpuhand() {
    return Image.asset(
      "images/$_cpuhand.png",
      width: 90,
      height: 90,
    );
  }

  int getCpuScore() {
    return _cpuScore;
  }

  Image getPlayerhand() {
    return Image.asset(
      "images/$_playerhand.png",
      width: 90,
      height: 90,
    );
  }

  int getPlayerScore() {
    return _playerScore;
  }

  void setHand(int imageno) {
    _playerhand = imageno;
    _cpuhand = new Random().nextInt(3) + 1;
    calculateScore();
  }

  void calculateScore() {
    if (_cpuhand != _playerhand) {
      if ((_cpuhand % 3) + 1 == _playerhand)
        _cpuScore++;
      else
        _playerScore++;
    }
  }

  void reset() {
    _cpuScore = _playerScore = 0;
    _cpuhand = _playerhand = 1;
  }
}
