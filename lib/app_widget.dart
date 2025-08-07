import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/core/theme/app_theme.dart';
import 'package:jogo_da_memoria/pages/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Memória',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: HomePage(),
    );
  }
}
