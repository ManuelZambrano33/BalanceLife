import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_config/viewmodel/informacion/video_viewmodel.dart';
 
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
 

class Tuto extends StatelessWidget {
  final String title = 'Tutorial';

  const Tuto({super.key}); 

  @override
  Widget build(BuildContext context) {
 
    return ChangeNotifierProvider(
      create: (_) => VideoViewModel('assets/your_video.mp4'),
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Container(
                height: 190,
                decoration: const BoxDecoration(
                  color: Color(0xFFCF4A03),
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
                      left: 20,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Positioned(
                      top: 90,
                      left: 30,
                      right: 30, 
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 2, 
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20), 

              Consumer<VideoViewModel>(
                builder: (context, viewModel, child) {
                  return viewModel.controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: viewModel.controller.value.aspectRatio,
                          child: VideoPlayer(viewModel.controller),
                        )
                      : const Center(child: CircularProgressIndicator());
                },
              ),

  
              Consumer<VideoViewModel>(
                builder: (context, viewModel, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          viewModel.isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.green,
                          size: 40,
                        ),
                        onPressed: () {
                          viewModel.togglePlayPause();   
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
