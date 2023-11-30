import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    var jmpfbmx = Uri.parse('https://github.com/jmpfbmx/');
    var weatherflow = Uri.parse('https://github.com/flutterprojectsbyj/TicTacToe');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            GestureDetector(
              onTap: () => _launchUrl(weatherflow),
              child: Image.asset(
                'assets/images/tictactoe.jpg',
                width: 256,
                height: 256,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Tic Tac Toe",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
            ),
            const SizedBox(height: 8),
            const Text(
              "Version 1.0.0",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => _launchUrl(jmpfbmx),
              child: const Text(
                "© Jose P. (jmpfbmx)",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: const Icon(Icons.arrow_back, color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}