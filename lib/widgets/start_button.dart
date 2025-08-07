import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/core/theme/app_theme.dart';

class StartButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback action;

  const StartButton({
    super.key,
    required this.title,
    required this.color,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: OutlinedButton(
        style: AppTheme.outlineButtonStyle(color: color),
        onPressed: action,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
