import 'package:flutter/material.dart';

class Category {
  final int id;
  final String title;
  final String imageUrl;

  const Category({
    required this.id,
    required this.title,
    required this.imageUrl,
    //Image.url('https://www.musculaction.com/images/intro-exercices-abdominaux.jpg'),
  });
}
