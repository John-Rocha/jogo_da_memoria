import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/core/constants/constants.dart';
import 'package:jogo_da_memoria/core/theme/app_theme.dart';
import 'package:jogo_da_memoria/pages/nivel_page.dart';
import 'package:jogo_da_memoria/widgets/logo.dart';
import 'package:jogo_da_memoria/widgets/recordes.dart';
import 'package:jogo_da_memoria/widgets/start_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  selecionarNivel(Modo modo, BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NivelPage(modo: modo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Logo(),
            StartButton(
              title: 'Modo Normal',
              color: Colors.white,
              action: () => selecionarNivel(Modo.normal, context),
            ),
            StartButton(
              title: 'Modo Round 6',
              color: AppTheme.color,
              action: () => selecionarNivel(Modo.round6, context),
            ),
            const SizedBox(height: 12),
            const Recordes(),
          ],
        ),
      ),
    );
  }
}
