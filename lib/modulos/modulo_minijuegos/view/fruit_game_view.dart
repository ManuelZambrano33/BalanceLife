import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/fruit_game_viewmodel.dart';

class FruitGameView extends StatefulWidget {
  const FruitGameView({super.key});

  @override
  State<FruitGameView> createState() => _FruitGameViewState();
}

class _FruitGameViewState extends State<FruitGameView> {
  int? selectedRow;
  int? selectedCol;
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<FruitGameViewModel>(context, listen: false).startGame();
    });
  }
void _showGameOverDialog(BuildContext context, int score) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: const Text('¡Juego Terminado!'),
      content: Text(
        'Obtuviste $score puntos.',
        style: const TextStyle(
          fontSize: 18, 
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF673AB7),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            _dialogShown = false;
            Provider.of<FruitGameViewModel>(context, listen: false).startGame(); 
            Navigator.of(context).pop();
          },
          child: const Text('Jugar de nuevo'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[600],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).pop(); 
            Navigator.of(context).pop(); 
          },
          child: const Text('Salir'),
        ),
      ],
    ),
  );
}

  void _onFruitTap(int row, int col) {
    if (selectedRow == null || selectedCol == null) {
      setState(() {
        selectedRow = row;
        selectedCol = col;
      });
    } else {
      Provider.of<FruitGameViewModel>(context, listen: false).swapFruits(
        selectedRow!,
        selectedCol!,
        row,
        col,
      );
      setState(() {
        selectedRow = null;
        selectedCol = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Container(
            height: 180,
            decoration: const BoxDecoration(
              color: Color(0xFF3F7D58),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const Positioned(
                  top: 120,
                  left: 35,
                  child: Text(
                    'Fruit Rush',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 10,
                  child: SizedBox(
                    width: 180,
                    height: 180,
                    child: Image.asset('assets/tomato.png', fit: BoxFit.contain),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Consumer<FruitGameViewModel>(
              builder: (context, viewModel, _) {
                return Column(
                  children: [
                    Text("Tiempo restante: ${viewModel.remainingTime}s", style: const TextStyle(fontSize: 20)),
                    Text("Puntos: ${viewModel.score}", style: const TextStyle(fontSize: 20)),
                  ],
                );
              },
            ),
          ),

          Expanded(
            child: Consumer<FruitGameViewModel>(
              builder: (context, viewModel, _) {
                if (viewModel.remainingTime == 0 && !_dialogShown) {
                  _dialogShown = true;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _showGameOverDialog(context, viewModel.score);
                  });
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemCount: 36,
                  itemBuilder: (context, index) {
                    int row = index ~/ 6;
                    int col = index % 6;
                    final fruit = viewModel.grid[row][col];
                    return GestureDetector(
                      onTap: () => _onFruitTap(row, col),
                      child: Container(
                        decoration: BoxDecoration(
                          border: (row == selectedRow && col == selectedCol)
                              ? Border.all(color: Colors.red, width: 3)
                              : null,
                        ),
                        child: fruit != null
                            ? Image.asset(fruit.imagePath, fit: BoxFit.cover)
                            : const SizedBox.shrink(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
