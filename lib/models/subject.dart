import 'package:flutter/material.dart';

class Subject {
  final String name;
  final String schedule;
  final IconData icon;
  final Color color;

  const Subject({
    required this.name,
    required this.schedule,
    required this.icon,
    required this.color,
  });
}