import 'package:cook/main_page.dart';
import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeDetailPage({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(recipe.photo),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(
                    "Время приготовления: ${recipe.time} минут",
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 10),
                  Text("Калорийность: ${recipe.calorie} на 100 грамм",
                      style: TextStyle(fontSize: 17)),
                  const SizedBox(height: 10),
                  const Text("Описание:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(recipe.description, style: TextStyle(fontSize: 17)),
                  const SizedBox(height: 10),
                  const Text("Инструкции:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(recipe.instructions, style: TextStyle(fontSize: 17)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
