import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Memória',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            'Bem-vindo ao Jogo da Memória!',
            style: TextStyle(fontSize: 24, color: Colors.deepPurple),
          ),
        ),
      ),
    );
  }
}
