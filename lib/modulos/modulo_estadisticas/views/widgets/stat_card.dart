import 'package:flutter/material.dart';
import '../../models/stats_model.dart';

class StatCard extends StatelessWidget {
  final StatsModel stat;

  const StatCard({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: stat.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(stat.icon, size: 50, color: Colors.white),
          const SizedBox(height: 10),
          Text(stat.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          Text("${stat.value} ${stat.unit}", style: const TextStyle(fontSize: 14, color: Colors.white)),
        ],
      ),
    );
  }
}