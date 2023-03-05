import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final List<dynamic> ingredients;

  const RecipeCard({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
  }) : super(key: key);

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  Future deleteRecipe() async {
    try {
      await FirebaseFirestore.instance
          .collection('recipes')
          .where('title', isEqualTo: widget.title)
          .where('description', isEqualTo: widget.description)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          element.reference.delete();
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Ingredients',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.ingredients.length,
                    itemBuilder: (context, index) {
                      return Text(
                        widget.ingredients[index],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // 2 floating action buttons for delete and edit
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              deleteRecipe();
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.delete),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/edit-recipe',
                arguments: {
                  'id': widget.id,
                  'title': widget.title,
                  'description': widget.description,
                  'ingredients': widget.ingredients,
                },
              );
            },
            child: const Icon(Icons.edit),
          ),
        ],
      ),

    );
  }
}
