import 'package:cook/text_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:cook/registration.dart';
import 'package:cook/main_page.dart';
import 'package:cook/service/PocketbaseService.dart';

class AddRecipePage extends StatefulWidget {
  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final pb = PocketBaseService.pb;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _timeController = TextEditingController();
  final _calorieController = TextEditingController();
  bool isVegan = false;

  Future<void> addRecipe() async {
    try {
      await pb.collection("recipes").create(body: {
        "title": _titleController.text,
        "description": _descriptionController.text,
        "instructions": _instructionsController.text,
        "user_id": pb.authStore.model.id,
        "vegan": isVegan,
        "time": double.parse(_timeController.text),
        "calorie": _calorieController.text
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: TextFieldDecoration("Название"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: TextFieldDecoration("Описание"),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _instructionsController,
              decoration: TextFieldDecoration("Рецепт"),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _timeController,
              decoration: TextFieldDecoration("Время приготовления (минут)"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _calorieController,
              decoration: TextFieldDecoration("Калорийность"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              value: isVegan,
              onChanged: (val) => {setState(() {
                isVegan = val;
              })},
              title: const Text("Вегатерианское"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => {addRecipe()},
              child: const Text("Добавить"),
            )
          ],
        )
      )
    );
  }
}





