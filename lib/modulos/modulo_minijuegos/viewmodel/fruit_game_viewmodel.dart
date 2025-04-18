import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../model/fruit_model.dart';
import '../repo/user_repository.dart';

class FruitGameViewModel with ChangeNotifier {
  List<List<Fruit?>> grid = [];
  int score = 0;
  late Timer _timer;
  int remainingTime = 60;
  bool _gameOver = false;

  final List<String> fruitImages = [
    'assets/canasta/fresa.png',
    'assets/canasta/coco.png',
    'assets/canasta/kiwi.png',
    'assets/canasta/manzana.png',
    'assets/canasta/melon.png',
    'assets/canasta/sandia.png',
    'assets/canasta/naranja.png',
  ];
 
  final UserRepository _userRepository;  
  final int idUsuario;
 
  FruitGameViewModel(this._userRepository, this.idUsuario);

  void startGame() {
    score = 0;
    remainingTime = 60;
    _gameOver = false;  
    _generateGrid();
    _startTimer();
    _checkMatches();  
    notifyListeners();
  }

  void restartGame() {
    startGame();  
  }

  void _generateGrid() {
    final random = Random();
    grid = List.generate(6, (_) {
      return List.generate(6, (_) {
        String image = fruitImages[random.nextInt(fruitImages.length)];
        return Fruit(imagePath: image);
      });
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
        notifyListeners();
      } else {
        _endGame();  
        timer.cancel();
      }
    });
  }

  void swapFruits(int row1, int col1, int row2, int col2) {
    if (_gameOver || !_areAdjacent(row1, col1, row2, col2)) return;

    final temp = grid[row1][col1];
    grid[row1][col1] = grid[row2][col2];
    grid[row2][col2] = temp;

    notifyListeners();
    _checkMatches();
  }

  bool _areAdjacent(int row1, int col1, int row2, int col2) {
    final dr = (row1 - row2).abs();
    final dc = (col1 - col2).abs();
    return (dr == 1 && dc == 0) || (dr == 0 && dc == 1);
  }

  Future<void> _checkMatches() async {
    final matches = <Point<int>>{};
    int comboPoints = 0;  

    // Recorre filas
    for (int row = 0; row < 6; row++) {
      for (int col = 0; col < 4; col++) {
        final fruit = grid[row][col];
        if (fruit != null &&
            grid[row][col + 1]?.imagePath == fruit.imagePath &&
            grid[row][col + 2]?.imagePath == fruit.imagePath) {
          matches.add(Point(row, col));
          matches.add(Point(row, col + 1));
          matches.add(Point(row, col + 2));

          comboPoints += 5; 
        }
      }
    }

    // Recorre columnas
    for (int col = 0; col < 6; col++) {
      for (int row = 0; row < 4; row++) {
        final fruit = grid[row][col];
        if (fruit != null &&
            grid[row + 1][col]?.imagePath == fruit.imagePath &&
            grid[row + 2][col]?.imagePath == fruit.imagePath) {
          matches.add(Point(row, col));
          matches.add(Point(row + 1, col));
          matches.add(Point(row + 2, col));

 
          comboPoints += 5;
        }
      }
    }

  
    if (matches.isNotEmpty) {
      for (var match in matches) {
        grid[match.x][match.y] = null;
      }
      score += comboPoints;  
      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 300));
      _dropFruits();
      _fillEmptySpaces();
      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 300));
      _checkMatches();  
    }
  }

  void _dropFruits() {
    for (int col = 0; col < 6; col++) {
      int emptyRow = 5;
      for (int row = 5; row >= 0; row--) {
        if (grid[row][col] != null) {
          grid[emptyRow][col] = grid[row][col];
          if (emptyRow != row) {
            grid[row][col] = null;
          }
          emptyRow--;
        }
      }
    }
  }

  void _fillEmptySpaces() {
    final random = Random();
    for (int row = 0; row < 6; row++) {
      for (int col = 0; col < 6; col++) {
        if (grid[row][col] == null) {
          String image = fruitImages[random.nextInt(fruitImages.length)];
          grid[row][col] = Fruit(imagePath: image);
        }
      }
    }
  }

  Future<void> _endGame() async {
    _gameOver = true;  
    int puntosGanados = score;  

    await _userRepository.sumarPuntos(idUsuario, puntosGanados);  

    notifyListeners();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
