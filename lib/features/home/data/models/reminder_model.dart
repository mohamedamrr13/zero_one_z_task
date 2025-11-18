import 'package:flutter/material.dart';

class ReminderModel {
  final String title;
  final String description;
  final String date;
  final String frequency;
  final Color backgroundColor;

  ReminderModel({
    required this.title,
    required this.description,
    required this.date,
    required this.frequency,
    required this.backgroundColor,
  });
}
