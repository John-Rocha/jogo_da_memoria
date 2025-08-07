import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jogo_da_memoria/app_widget.dart';
import 'package:jogo_da_memoria/cubits/game_cubit.dart';
import 'package:jogo_da_memoria/repositories/recordes_repository.dart';

Future<void> main() async {
  await Hive.initFlutter();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RecordesRepository>(
          create: (_) => RecordesRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GameCubit>(
            create: (context) => GameCubit(
              recordesRepository: context.read<RecordesRepository>(),
            ),
          ),
        ],
        child: const AppWidget(),
      ),
    ),
  );
}
