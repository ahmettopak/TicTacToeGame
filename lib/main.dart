import 'package:flutter/material.dart';
import 'package:neon_widgets/neon_widgets.dart';
import "package:tic_tac_toe/utils/game.dart";
import "package:tic_tac_toe/utils/color.dart";
import 'package:neon/neon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //adding the necessary variables
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0;
  String result = "";
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];

  Game game = Game();

  //let's initi the GameBoard
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;

    String ek = "de";
    if (lastValue == "O") {
      ek = "da";
    }

    String oyuncu = "Sıra ${lastValue} ${ek}".toUpperCase();
    "";
    if (result != "") {
      oyuncu = result;
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Neon(
            text: oyuncu,
            font: NeonFont.Membra,
            fontSize: 50,
            color: Colors.cyan,
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardlenth ~/ 3,
              padding: EdgeInsets.all(8.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(Game.boardlenth, (index) {
                return InkWell(
                  onTap: gameOver
                      ? null
                      : () {
                          if (game.board![index] == "") {
                            setState(() {
                              game.board![index] = lastValue;
                              turn++;
                              gameOver = game.winnerCheck(
                                  lastValue, index, scoreboard, 3);

                              if (gameOver) {
                                result = "$lastValue Kazandı";
                              } else if (!gameOver && turn == 9) {
                                result = "Berabere";
                                gameOver = true;
                              }
                              if (lastValue == "X")
                                lastValue = "O";
                              else
                                lastValue = "X";
                            });
                          }
                        },
                  child: oNeonContainer(
                    spreadColor: Colors.cyan.shade900,
                    width: Game.blocSize,
                    height: Game.blocSize,
                    child: Center(
                      child: oNeonText(
                        text: game.board![index],
                        spreadColor: Colors.white,
                        blurRadius: 10,
                        textSize: 60,
                        textColor: game.board![index] == "X"
                            ? Colors.cyan
                            : Colors.red,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextButton(
              onPressed: () {
                setState(
                  () {
                    game.board = Game.initGameBoard();
                    lastValue = "X";
                    gameOver = false;
                    turn = 0;
                    result = "";
                    scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
                  },
                );
              },
              child: Neon(
                text: "Yeniden Başla",
                color: Colors.cyan,
                fontSize: 25,
                font: NeonFont.Membra,
                flickeringText: true,

                // flickeringLetters: [0, 1, 2, 3, 4],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
