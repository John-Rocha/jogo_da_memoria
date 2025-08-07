class GameOpcao {
  final String id; // Identificador único para cada carta
  int opcao;
  bool matched;
  bool selected;

  GameOpcao({
    required this.id,
    required this.opcao,
    required this.matched,
    required this.selected,
  });
}
