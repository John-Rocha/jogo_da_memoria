# 🧠 Jogo da Memória

Um jogo da memória moderno desenvolvido em **Flutter** com arquitetura **BLoC/Cubit** para gerenciamento de estado.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![BLoC](https://img.shields.io/badge/BLoC-FF6B35?style=for-the-badge&logo=flutter&logoColor=white)

## 📋 Índice

- [Sobre o Projeto](#sobre-o-projeto)
- [Funcionalidades](#funcionalidades)
- [Modos de Jogo](#modos-de-jogo)
- [Arquitetura](#arquitetura)
- [Instalação](#instalação)
- [Como Jogar](#como-jogar)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Screenshots](#screenshots)

## 📖 Sobre o Projeto

O Jogo da Memória é uma aplicação Flutter que oferece uma experiência divertida e desafiadora para exercitar a memória. O jogo possui dois modos distintos, múltiplos níveis de dificuldade e um sistema completo de recordes.

### ✨ Características Principais

- **Arquitetura BLoC/Cubit**: Gerenciamento de estado moderno e reativo
- **Persistência de Dados**: Recordes salvos localmente com Hive
- **Design Responsivo**: Interface adaptável a diferentes tamanhos de tela
- **Animações Fluidas**: Transições suaves entre estados
- **Sistema de Recordes**: Acompanhe seu progresso em cada modo

## 🎮 Funcionalidades

### 🕹️ Sistema de Jogo

- ✅ Dois modos de jogo distintos (Normal e Round 6)
- ✅ 9 níveis de dificuldade (6 a 28 cartas)
- ✅ Sistema de pontuação dinâmico
- ✅ Animações de flip nas cartas
- ✅ Feedback visual para vitória/derrota

### 📊 Sistema de Recordes

- ✅ Persistência local com Hive
- ✅ Recordes separados por modo de jogo
- ✅ Visualização organizada por nível
- ✅ Atualização automática de melhores pontuações

### 🎨 Interface

- ✅ Design moderno e intuitivo
- ✅ Temas diferenciados por modo
- ✅ Animações fluidas
- ✅ Feedback visual rico

## 🎯 Modos de Jogo

### 🟢 Modo Normal

- **Objetivo**: Encontrar todos os pares de cartas
- **Pontuação**: Incrementa a cada jogada (+1 ponto)
- **Vitória**: Quando todos os pares são encontrados
- **Sem limite de tentativas**

### 🔴 Modo Round 6

- **Objetivo**: Encontrar todos os pares antes das chances acabarem
- **Pontuação**: Inicia com pontos iguais ao nível e decresce (-1 a cada erro)
- **Vitória**: Encontrar todos os pares com pontuação ≥ 0
- **Derrota**: Quando as chances restantes < pares restantes

## 🏗️ Arquitetura

O projeto utiliza **arquitetura BLoC/Cubit** para um gerenciamento de estado limpo e reativo:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│                 │    │                 │    │                 │
│   Presentation  │────│  Business Logic │────│      Data       │
│     (Widgets)   │    │   (Cubit/Bloc)  │    │  (Repository)   │
│                 │    │                 │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### 🧩 Componentes Principais

#### **GameCubit** (`lib/cubits/game_cubit.dart`)

- Gerencia toda a lógica do jogo
- Controla estado das cartas e pontuação
- Processa jogadas e verifica condições de vitória/derrota

#### **GameState** (`lib/cubits/game_state.dart`)

- Define os estados possíveis do jogo
- Estados: `GameInitial`, `GameInProgress`, `GameWon`, `GameLost`
- Estados imutáveis com `Equatable`

#### **RecordesRepository** (`lib/repositories/recordes_repository.dart`)

- Gerencia persistência de recordes
- Utiliza Hive para armazenamento local
- Stream para notificação de mudanças

#### **GameOpcao** (`lib/models/game_opcao.dart`)

- Modelo de dados para cada carta
- Contém ID único, número, e estados (matched/selected)

## 🚀 Instalação

### Pré-requisitos

- Flutter SDK (>= 3.8.1)
- Dart SDK
- Android Studio / VS Code
- Dispositivo Android/iOS ou Emulador

### Passos de Instalação

1. **Clone o repositório**

```bash
git clone https://github.com/seu-usuario/jogo_da_memoria.git
cd jogo_da_memoria
```

2. **Instale as dependências**

```bash
flutter pub get
```

3. **Execute o aplicativo**

```bash
flutter run
```

### 📱 Build para Produção

**Android (APK)**

```bash
flutter build apk --release
```

**Android (App Bundle)**

```bash
flutter build appbundle --release
```

**iOS**

```bash
flutter build ios --release
```

## 🎯 Como Jogar

### 🔄 Fluxo do Jogo

1. **Seleção do Modo**: Escolha entre Normal ou Round 6
2. **Seleção do Nível**: Escolha a dificuldade (6 a 28 cartas)
3. **Gameplay**:
   - Toque em duas cartas para virá-las
   - Se formarem par, elas permanecem viradas
   - Se não formarem par, elas viram de volta após 1 segundo
4. **Vitória/Derrota**: O jogo termina baseado nas condições do modo escolhido

### 🏆 Sistema de Pontuação

#### Modo Normal

- Inicia com 0 pontos
- +1 ponto a cada jogada (independente de acerto/erro)
- **Objetivo**: Menor pontuação possível

#### Modo Round 6

- Inicia com pontos = número de cartas do nível
- -1 ponto a cada erro
- +0 pontos nos acertos
- **Objetivo**: Maior pontuação possível

### 📈 Níveis Disponíveis

| Nível | Cartas | Layout | Dificuldade       |
| ----- | ------ | ------ | ----------------- |
| 6     | 6      | 2x3    | ⭐ Fácil          |
| 8     | 8      | 2x4    | ⭐ Fácil          |
| 10    | 10     | 3x4    | ⭐⭐ Médio        |
| 12    | 12     | 3x4    | ⭐⭐ Médio        |
| 16    | 16     | 4x4    | ⭐⭐⭐ Difícil    |
| 18    | 18     | 3x6    | ⭐⭐⭐ Difícil    |
| 20    | 20     | 4x5    | ⭐⭐⭐⭐ Expert   |
| 24    | 24     | 4x6    | ⭐⭐⭐⭐ Expert   |
| 28    | 28     | 4x7    | ⭐⭐⭐⭐⭐ Master |

## 📁 Estrutura do Projeto

```
lib/
├── 📱 main.dart                    # Ponto de entrada da aplicação
├── 🎨 app_widget.dart              # Widget raiz da aplicação
├── ⚙️ game_settings.dart           # Configurações do jogo
│
├── 🧠 cubits/                      # Gerenciamento de Estado (BLoC)
│   ├── game_cubit.dart             # Lógica principal do jogo
│   └── game_state.dart             # Estados do jogo
│
├── 📄 pages/                       # Telas da aplicação
│   ├── home_page.dart              # Tela inicial
│   ├── nivel_page.dart             # Seleção de nível
│   ├── game_page.dart              # Tela principal do jogo
│   └── recordes_page.dart          # Visualização de recordes
│
├── 🧩 widgets/                     # Componentes reutilizáveis
│   ├── card_game.dart              # Widget da carta
│   ├── card_nivel.dart             # Widget de seleção de nível
│   ├── feedback_game.dart          # Feedback de vitória/derrota
│   ├── game_score.dart             # Exibição da pontuação
│   ├── logo.dart                   # Logo da aplicação
│   ├── recordes.dart               # Lista de recordes
│   └── start_button.dart           # Botão de ação
│
├── 📦 models/                      # Modelos de dados
│   ├── game_opcao.dart             # Modelo da carta
│   └── game_play.dart              # Modelo da jogada
│
├── 🗄️ repositories/                # Camada de dados
│   └── recordes_repository.dart    # Gerenciamento de recordes
│
└── 🎨 core/                        # Configurações centrais
    ├── constants/
    │   └── constants.dart          # Constantes da aplicação
    └── theme/
        └── app_theme.dart          # Tema visual
```

## 🛠️ Tecnologias Utilizadas

### 📚 Dependências Principais

| Tecnologia          | Versão   | Descrição                           |
| ------------------- | -------- | ----------------------------------- |
| **Flutter**         | >= 3.8.1 | Framework de desenvolvimento mobile |
| **flutter_bloc**    | ^8.1.6   | Gerenciamento de estado reativo     |
| **equatable**       | ^2.0.5   | Comparação de objetos imutáveis     |
| **hive**            | ^2.2.3   | Banco de dados local NoSQL          |
| **hive_flutter**    | ^1.1.0   | Integração Hive com Flutter         |
| **google_fonts**    | ^6.3.0   | Fontes personalizadas               |
| **cupertino_icons** | ^1.0.8   | Ícones iOS                          |

### 🏗️ Padrões Arquiteturais

- **BLoC Pattern**: Separação entre lógica de negócio e apresentação
- **Repository Pattern**: Abstração da camada de dados
- **State Management**: Estados imutáveis e reativos
- **Dependency Injection**: Injeção de dependências com BlocProvider

## 🐛 Correções de Bugs Realizadas

Durante o desenvolvimento, foram identificados e corrigidos dois bugs importantes:

### 🔧 Bug #1: Carta não podia ser selecionada novamente

- **Problema**: Inconsistência entre estado do widget e do Cubit
- **Solução**: Eliminação de mutação direta de objetos, uso exclusivo do estado do BLoC

### 🔧 Bug #2: Carta não abria quando já havia visto o par

- **Problema**: Identificação ambígua de cartas com mesmo número
- **Solução**: Implementação de ID único para cada carta individual

## 🎨 Screenshots

_[Adicione aqui screenshots da aplicação mostrando as diferentes telas]_

### Tela Inicial

- Menu principal com opções de modo

### Seleção de Nível

- Grid com níveis disponíveis

### Gameplay

- Cartas viradas e contador de pontos

### Recordes

- Lista de melhores pontuações por modo

## 🤝 Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para:

1. Fazer fork do projeto
2. Criar uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abrir um Pull Request

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 👨‍💻 Autor

**Johnathan Rocha**

- GitHub: [@John-Rocha](https://github.com/John-Rocha)
- LinkedIn: [Johnathan Rocha](https://linkedin.com/in/johnathan-rocha)

## 🙏 Agradecimentos

- Flutter Team pelo excelente framework
- BLoC Library pelos padrões de arquitetura
- Comunidade Flutter pelas contribuições e recursos

---

⭐ **Se gostou do projeto, deixe uma estrela!** ⭐
