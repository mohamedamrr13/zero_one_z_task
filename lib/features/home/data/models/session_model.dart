import 'package:flutter/material.dart';

class SessionModel {
  final String title;
  final String description;
  final String date;
  final String time;
  final Color backgroundColor;

  SessionModel({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.backgroundColor,
  });
}
