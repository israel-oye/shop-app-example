import 'package:flutter/material.dart';

enum AvatarChoice{
  red('Red', Colors.red),
  blue('Blue', Colors.blue),
  orange('Orange', Colors.orange),
  purple('Purple', Colors.purpleAccent),
  green('Green', Colors.lightGreen);

  final String name;
  final Color color;

  const AvatarChoice(this.name, this.color);
}


