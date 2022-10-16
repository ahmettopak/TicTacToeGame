import 'package:flutter/material.dart';
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
  int turn = 0; // to check the draw
  String result = "";
  List<int> scoreboard = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ]; //the score are for the different combination of the game [Row1,2,3, Col1,2,3, Diagonal1,2];
  //let's declare a new Game components

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

    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Neon(
            text: "Sıra ${lastValue} ${ek}".toUpperCase(),
            font: NeonFont.Membra,
            fontSize: 50,
            color: Colors.cyan,
          ),
          // Text(
          //   ,
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 58,
          //   ),
          // ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardlenth ~/ 3,
              padding: EdgeInsets.all(16.0),
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
                  child: Container(
                    width: Game.blocSize,
                    height: Game.blocSize,
                    decoration: BoxDecoration(
                      color: MainColor.secondaryColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Center(
                      child: Text(
                        game.board![index],
                        style: TextStyle(
                          color: game.board![index] == "X"
                              ? Colors.blue
                              : Colors.pink,
                          fontSize: 64.0,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            result,
            style: TextStyle(color: Colors.white, fontSize: 54.0),
          ),
          // ElevatedButton.icon(
          //   onPressed: () {
          //     setState(() {
          //       //erase the board
          //       game.board = Game.initGameBoard();
          //       lastValue = "X";
          //       gameOver = false;
          //       turn = 0;
          //       result = "";
          //       scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
          //     });
          //   },
          //   icon: Icon(Icons.replay),
          //   label: Text("Yeniden Başla"),
          // ),

          TextButton(
              onPressed: () {
                setState(
                  () {
                    //erase the board
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
                text: 'Retro',
                color: Colors.green,
                fontSize: 50,
                font: NeonFont.Membra,
                flickeringText: true,
                flickeringLetters: [0, 1, 2, 3, 4],
              ))
        ],
      ),
    );
    //the first step is organise our project folder structure
  }
}
