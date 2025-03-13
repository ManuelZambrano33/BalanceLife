import 'package:flutter/material.dart';

class StatsModel {
  final String title;
  final double value;
  final String unit;
  final Color color;
  final IconData icon;

  StatsModel({
    required this.title,
    required this.value,
    required this.unit,
    required this.color,
    required this.icon,
  });
}