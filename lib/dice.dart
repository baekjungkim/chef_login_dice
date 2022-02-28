import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Dice extends StatefulWidget {
  const Dice({Key? key}) : super(key: key);

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  int leftDice = 1;
  int rightDice = 2;

  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text("Dice Game"),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(32.0),
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset('image/dice$leftDice.png'),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Image.asset('image/dice$rightDice.png'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent,
                minimumSize: Size(100.0, 60.0),
              ),
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 50.0,
              ),
              onPressed: () {
                int stopTimeCounter = 0;
                if (!_timer.isActive) {
                  _timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
                    stopTimeCounter++;
                    setState(() {
                      leftDice = Random().nextInt(6) + 1;
                      rightDice = Random().nextInt(6) + 1;
                    });
                    if (stopTimeCounter == 10) {
                      timer.cancel();
                      showToast('Left Dice: $leftDice, Right Dice: $rightDice');
                    }
                  });
                } else {
                  showToast('Choosing the dice, please wait');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

void showToast(String message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP_RIGHT,
  );
}
