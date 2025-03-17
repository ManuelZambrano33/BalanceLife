import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        elevation: 0, 
        flexibleSpace: Stack(
          children: [
            // El avatar en la parte inferior derecha
            Positioned(
              bottom: 10,  // Distancia desde la parte inferior del AppBar
              right: 20,   // Distancia desde la parte derecha del AppBar
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
