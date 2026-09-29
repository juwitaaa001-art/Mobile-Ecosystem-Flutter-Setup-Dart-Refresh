import 'package:flutter/material.dart';

class Course {
  final String title;
  final String lab;
  final String time;
  final String status;
  final String assistant;
  final IconData icon;

  const Course({
    required this.title,
    required this.lab,
    required this.time,
    required this.status,
    required this.assistant,
    required this.icon,
  });
}