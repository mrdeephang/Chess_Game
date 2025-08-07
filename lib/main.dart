import 'package:chess_game/screens/gamepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: GamePage(),
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
    );
  }
}
