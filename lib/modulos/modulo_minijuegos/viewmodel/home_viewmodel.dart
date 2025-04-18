import 'package:flutter/material.dart';

class HomeViewModel {
  void irAlMinijuego1(BuildContext context) {
    Navigator.pushNamed(context, '/minijuego1'); 
  }

  void irAlMinijuego2(BuildContext context) {
    Navigator.pushNamed(context, '/minijuego2');
  }
}
