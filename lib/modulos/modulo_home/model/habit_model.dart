import 'package:flutter/material.dart';

class HabitModel {
  final String title;
  final String iconPath;
  final Color color;
  final String route;

  HabitModel({
    required this.title,
    required this.iconPath,
    required this.color,
    required this.route,
  });
}