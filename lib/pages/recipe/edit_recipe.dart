import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditRecipe extends StatefulWidget {
  const EditRecipe({Key? key}) : super(key: key);

  @override
  State<EditRecipe> createState() => _EditRecipeState();
}



class _EditRecipeState extends State<EditRecipe> {
  // 2 text controllers for the 3 text fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // list of ingredients
  final List<String> _ingredients = <String>[];


  Future editRecipeToFireStore() async {
    try {
      await FirebaseFirestore.instance.collection('recipes').add({
        'id': DateTime.now().toString(),
        'title': _titleController.text,
        'description': _descriptionController.text,
        'ingredients': _ingredients,
        'email': FirebaseAuth.instance.currentUser!.email,
      });

      //   go to home page
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      fallbackHeight: 200,
      fallbackWidth: 200,
    );
  }
}
