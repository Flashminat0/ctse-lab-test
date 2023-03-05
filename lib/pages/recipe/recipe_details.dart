import 'package:flutter/material.dart';

import '../../components/recipe_card.dart';

class RecipeDetailPage extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final List<dynamic> ingredients;

  const RecipeDetailPage(
      {Key? key,
      required this.id,
      required this.title,
      required this.description,
      required this.ingredients})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RecipeCard(
      id: id,
      title: title,
      description: description,
      ingredients: ingredients,
    );
  }
}
