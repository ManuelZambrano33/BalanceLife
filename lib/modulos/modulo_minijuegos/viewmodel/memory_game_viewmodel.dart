import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../model/card_model.dart';

class MemoryGameViewModel extends ChangeNotifier {
  List<CardModel> cards = [];
  CardModel? firstCard;
  int matchedPairs = 0;
  int score = 0;
  Timer? timer;
  int timeLeft = 60;
  bool isGameOver = false;  

  final List<List<int>> levelConfigs = [
    [4, 4], 
    [5, 4], 
    [5, 4], 
  ];

  int currentLevelIndex = 0;

  final List<String> imagePaths = [
    'assets/cartas/img1.png',
    'assets/cartas/img2.png',
    'assets/cartas/img3.png',
    'assets/cartas/img4.png',
    'assets/cartas/img5.png',
    'assets/cartas/img6.png',
    'assets/cartas/img7.png',
    'assets/cartas/img8.png',
    'assets/cartas/img9.png',
    'assets/cartas/img10.jpg',
  ];

  void initGame() {
    score = 0;
    matchedPairs = 0;
    timeLeft = 60;
    isGameOver = false;  
    currentLevelIndex = 0;
    _startLevel();
  }

  void _startLevel() {
    matchedPairs = 0;
    timeLeft = 60;
    isGameOver = false;   
    timer?.cancel();

    final rows = levelConfigs[currentLevelIndex][0];
    final cols = levelConfigs[currentLevelIndex][1];
    final totalCards = rows * cols;
    final pairCount = totalCards ~/ 2;

    final deck = _generateDeck(pairCount);
    deck.shuffle(Random());

    cards = deck.map((image) => CardModel(imagePath: image)).toList();
    notifyListeners();
    _startTimer();
  }

  List<String> _generateDeck(int pairCount) {
    final deck = List<String>.generate(pairCount, (index) => imagePaths[index % imagePaths.length]);
    return [...deck, ...deck];
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (isGameOver) {
        t.cancel();  
      } else {
        timeLeft--;
        if (timeLeft <= 0) {
          t.cancel();
          _endGame();
        }
        notifyListeners();
      }
    });
  }

  void flipCard(int index) {
    if (isGameOver) return;   

    final card = cards[index];
    if (card.isFlipped || card.isMatched) return;

    card.isFlipped = true;
    notifyListeners();

    if (firstCard == null) {
      firstCard = card;
    } else {
      if (firstCard!.imagePath == card.imagePath) {
        firstCard!.isMatched = true;
        card.isMatched = true;
        matchedPairs++;
        firstCard = null;

        if (matchedPairs == (cards.length ~/ 2)) {
          _handleLevelComplete();
        }
      } else {
        Future.delayed(const Duration(milliseconds: 800), () {
          card.isFlipped = false;
          firstCard!.isFlipped = false;
          firstCard = null;
          notifyListeners();
        });
      }
    }
  }

  void _handleLevelComplete() {
    score += 100;

    if (currentLevelIndex < levelConfigs.length - 1) {
      currentLevelIndex++;
      _startLevel();
    } else {
      _endGame(); 
    }
  }

  void _endGame() {
    isGameOver = true;   
    timer?.cancel();
    notifyListeners();   
  }

  int get currentLevel => currentLevelIndex + 1;
}
