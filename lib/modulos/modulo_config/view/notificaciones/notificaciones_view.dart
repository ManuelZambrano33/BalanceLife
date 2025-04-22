import 'package:flutter/material.dart';
import 'package:front_balancelife/modulos/modulo_config/viewmodel/notificaciones/notification_viewmodel.dart';
 
import 'package:provider/provider.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationViewModel(),
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Container(
                height: 180,
                decoration: const BoxDecoration(
                  color: Color(0xFF720455), 
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
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const Positioned(
                      top: 110,
                      left: 30,
                      child: Text(
                        'Notificaciones',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Activar notificaciones',
                      style: TextStyle(fontSize: 18),
                    ),
                    Consumer<NotificationViewModel>(
                      builder: (context, viewModel, _) {
                        return Switch(
                          value: viewModel.isEnabled,
                          onChanged: (value) {
                            viewModel.toggleNotification();
                          },
                          activeColor: Colors.green,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
