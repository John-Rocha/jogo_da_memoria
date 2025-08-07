import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jogo_da_memoria/core/constants/constants.dart';
import 'package:jogo_da_memoria/core/theme/app_theme.dart';
import 'package:jogo_da_memoria/repositories/recordes_repository.dart';

class RecordesPage extends StatefulWidget {
  final Modo modo;

  const RecordesPage({super.key, required this.modo});

  @override
  State<RecordesPage> createState() => _RecordesPageState();
}

class _RecordesPageState extends State<RecordesPage> {
  getModo() {
    return widget.modo == Modo.normal ? 'Normal' : 'Round 6';
  }

  List<Widget> getRecordesList(Map recordes) {
    final List<Widget> widgets = [];

    recordes.forEach((nivel, score) {
      widgets.add(
        ListTile(
          title: Text('Nível $nivel'),
          trailing: Text(score.toString()),
          tileColor: Colors.grey[900],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
      );

      widgets.add(const Divider(color: Colors.transparent));
    });

    if (widgets.isEmpty) {
      widgets.add(
        const Center(
          child: Text('AINDA NÃO RECORDES!'),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final repository = context.read<RecordesRepository>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recordes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder<void>(
          stream: repository.recordesStream,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 36, bottom: 24),
                  child: Center(
                    child: Text(
                      'Modo ${getModo()}',
                      style: const TextStyle(
                        fontSize: 28,
                        color: AppTheme.color,
                      ),
                    ),
                  ),
                ),
                ...getRecordesList(
                  widget.modo == Modo.normal
                      ? repository.recordesNormal
                      : repository.recordesRound6,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
