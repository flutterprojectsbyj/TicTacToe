import 'dart:math';
import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key, this.singlePlayer = false, this.player2name = ""});

  final bool singlePlayer;
  final String player2name;

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> board = List.filled(9, ''); // Represents the Tic Tac Toe board
  late bool startPlayer1;
  late bool isPlayer1Turn; // Indicates whether it's Player 1's turn or not
  bool gameEnded = false; // Indicates whether the game has ended
  String winner = ''; // Stores the winner of the game
  late String player1Piece;
  late String player2Piece;

  @override
  void initState() {
    super.initState();
    _randomizeStartingPlayer();
  }

  void _randomizeStartingPlayer() {
    startPlayer1 = Random().nextBool();
    startPlayer1 ? player1Piece = 'X' : player1Piece = 'O';
    player2Piece = (player1Piece == 'X') ? 'O' : 'X';
    (!startPlayer1) ? isPlayer1Turn = false : isPlayer1Turn = true;
    setState(() {
      if (!isPlayer1Turn && widget.singlePlayer) {
        // If the bot starts first, make the bot's move
        _botMove();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            startPlayer1
                ? 'Player 1: $player1Piece'
                : '${(widget.player2name.isEmpty) ? "Player 2" : widget.player2name}: $player2Piece',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: startPlayer1 && player1Piece == 'X' || !startPlayer1 && player2Piece == 'X'
                  ? const Color.fromRGBO(98, 98, 255, 1)
                  : const Color.fromRGBO(255, 167, 38, 1),
            ),
          ),
          Text(
            startPlayer1
                ? '${(widget.player2name.isEmpty) ? "Player 2" : widget.player2name}: $player2Piece'
                : 'Player 1: $player1Piece',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: !startPlayer1 && player1Piece == 'O' || startPlayer1 && player2Piece == 'O'
                  ? const Color.fromRGBO(255, 167, 38, 1)
                  : const Color.fromRGBO(98, 98, 255, 1),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => _onTileTapped(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(
                          fontSize: 40.0,
                          color: board[index] == 'X'
                              ? const Color.fromRGBO(98, 98, 255, 1)
                              : const Color.fromRGBO(255, 167, 38, 1),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            gameEnded
                ? winner.isNotEmpty
                ? 'Winner: $winner'
                : 'It\'s a draw!'
                : widget.singlePlayer
                ? isPlayer1Turn
                ? 'Your Turn'
                : 'Bot\'s Turn'
                : isPlayer1Turn && startPlayer1
                ? 'Player 1\'s Turn'
                : !isPlayer1Turn && startPlayer1
                ? "Player 2\'s Turn"
                : !isPlayer1Turn && !startPlayer1
                ? 'Player 2\'s Turn'
                : 'Player 1\'s Turn',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _onTileTapped(int index) {
    if (!gameEnded && board[index].isEmpty) {
      setState(() {
        String currentPlayerSymbol = (widget.singlePlayer) ? startPlayer1 ? 'X' : 'O' : isPlayer1Turn ? player1Piece : player2Piece;
        board[index] = currentPlayerSymbol;
        isPlayer1Turn = !isPlayer1Turn;
        if (_checkForWinner()) {
          gameEnded = true;
          winner = widget.singlePlayer
              ? isPlayer1Turn
              ? 'Bot ${widget.player2name}'
              : 'Player 1'
              : isPlayer1Turn && !startPlayer1
              ? 'Player 2'
              : 'Player 1';
        } else if (_isBoardFull()) {
          gameEnded = true;
        } else if (widget.singlePlayer && !isPlayer1Turn) {
          // Bot's turn
          _botMove();
        }
      });
    }
  }

  bool _checkForWinner() {
    // Check rows, columns, and diagonals for a winner
    for (int i = 0; i < 3; i++) {
      if (board[i * 3] == board[i * 3 + 1] &&
          board[i * 3 + 1] == board[i * 3 + 2] &&
          board[i * 3].isNotEmpty) {
        return true; // Check rows
      }
      if (board[i] == board[i + 3] &&
          board[i + 3] == board[i + 6] &&
          board[i].isNotEmpty) {
        return true; // Check columns
      }
    }
    if (board[0] == board[4] && board[4] == board[8] && board[0].isNotEmpty) {
      return true; // Check diagonal \
    }
    if (board[2] == board[4] && board[4] == board[6] && board[2].isNotEmpty) {
      return true; // Check diagonal /
    }
    return false;
  }

  bool _isBoardFull() {
    return !board.contains('');
  }

  void _botMove() {
    // Check for a winning move for the bot
    int winningMove = _getWinningMove();
    if (winningMove != -1) {
      board[winningMove] = (startPlayer1) ? 'O' : 'X';
    } else {
      // Check for a move to block the human player from winning
      int blockingMove = _getBlockMove();
      if (blockingMove != -1) {
        board[blockingMove] = (startPlayer1) ? 'O' : 'X';
      } else {
        // If no winning or blocking move, choose a random empty spot
        List<int> emptySpots = [];
        for (int i = 0; i < 9; i++) {
          if (board[i].isEmpty) {
            emptySpots.add(i);
          }
        }

        if (emptySpots.isNotEmpty) {
          int randomIndex = Random().nextInt(emptySpots.length);
          int botMoveIndex = emptySpots[randomIndex];
          board[botMoveIndex] = (startPlayer1) ? 'O' : 'X';
        }
      }
    }

    isPlayer1Turn = true;

    if (_checkForWinner()) {
      gameEnded = true;
      winner = 'Bot ${widget.player2name}';
    } else if (_isBoardFull()) {
      gameEnded = true;
    }
  }

  int _getWinningMove() {
    // Check for a winning move for the bot
    for (int i = 0; i < 9; i++) {
      if (board[i].isEmpty) {
        board[i] = (startPlayer1) ? 'X' : 'O';
        if (_checkForWinner()) {
          board[i] = ''; // Undo the move
          return i;
        }
        board[i] = ''; // Undo the move
      }
    }
    return -1; // No winning move found
  }

  int _getBlockMove() {
    // Check for a move to block the human player from winning
    for (int i = 0; i < 9; i++) {
      if (board[i].isEmpty) {
        board[i] = (!startPlayer1) ? 'X' : 'O';
        if (_checkForWinner()) {
          board[i] = ''; // Undo the move
          return i;
        }
        board[i] = ''; // Undo the move
      }
    }
    return -1; // No blocking move found
  }
}
