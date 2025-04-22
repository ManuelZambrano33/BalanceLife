import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/memory_game_viewmodel.dart';

class MemoryGameView extends StatefulWidget {
  const MemoryGameView({super.key});

  @override
  State<MemoryGameView> createState() => _MemoryGameViewState();
}

class _MemoryGameViewState extends State<MemoryGameView> {
  bool _dialogShown = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MemoryGameViewModel()..initGame(),
      child: Consumer<MemoryGameViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.isGameOver && !_dialogShown) {
            _dialogShown = true;
            Future.delayed(Duration.zero, () {
              _showGameOverDialog(context, viewModel.score);
            });
          }

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
                          'Healthy Match',
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
                  child: Column(
                    children: [
                      Text("Tiempo restante: ${viewModel.timeLeft}s", style: const TextStyle(fontSize: 20)),
                      Text("Nivel: ${viewModel.currentLevel} | Puntos: ${viewModel.score}", style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
 
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: viewModel.levelConfigs[viewModel.currentLevel - 1][1],
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: viewModel.cards.length,
                    itemBuilder: (context, index) {
                      final card = viewModel.cards[index];
                      return GestureDetector(
                        onTap: () => viewModel.flipCard(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3E5F5),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFD6D3D3), width: 3),
                            image: card.isFlipped || card.isMatched
                                ? DecorationImage(
                                    image: AssetImage(card.imagePath),
                                    fit: BoxFit.cover,
                                  )
                                : const DecorationImage(
                                    image: AssetImage('assets/cartas/estrella.jpg'),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
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
            Provider.of<MemoryGameViewModel>(context, listen: false).initGame();
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


}
