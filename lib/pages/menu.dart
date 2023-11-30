import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe/pages/about.dart';
import 'package:tictactoe/pages/tic_tac_toe.dart';
import 'package:tictactoe/resources/bot.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Center(
            child: Text(
              "Tic Tac Toe",
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => TicTacToe(singlePlayer: true, player2name: botNames[Random().nextInt(botNames.length)])),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(47, 203, 66, 1),
              minimumSize: const Size(125, 50),
            ),
            child: const Text(
              'Single Player',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const TicTacToe(singlePlayer: false)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(64, 151, 117, 1),
              minimumSize: const Size(125, 50),
            ),
            child: const Text(
              '2 Players',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ]),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AboutPage()),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Text("About")
        ),
      ),
    );
  }
}