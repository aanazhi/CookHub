

import 'package:flutter/material.dart';
import 'package:cook/main_page.dart';
import 'package:cook/service/PocketbaseService.dart';

class RecipesListPage extends StatefulWidget {
  final Future<List<RecipeModel>> recipes;
  const RecipesListPage ({ Key? key, required this.recipes }): super(key: key);

  @override
  _RecipesListState createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesListPage> {
  final pb = PocketBaseService.pb;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<RecipeModel>>(
        future: widget.recipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Произошла ошибка'));
          } else if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final recipe = snapshot.data![index];
                return ListTile(
                  leading: Image.network(
                    recipe.photo,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                  ),
                  title: Text(
                  recipe.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 15, 
                  ),
                ),
                subtitle: Text(
                  ' Время приготовления: ${recipe.time.toString()} минут \n'
                  '\n'
                  '${recipe.calorie} ккал на 100 грамм'
                  ,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 13, 
                    color: Colors.black,
                  ),
                ),
                  onTap: () {
                    // Действие при нажатии на элемент списка
                  },
                );
              },
              separatorBuilder: (context, index) => Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    height: 2,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Нет данных'));
          }
        },
      ),
    );
  }
}
