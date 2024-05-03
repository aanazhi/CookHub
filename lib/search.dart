import 'package:cook/main_page.dart';
import 'package:cook/recipes_list.dart';
import 'package:flutter/material.dart';
import 'package:cook/service/PocketbaseService.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final pb = PocketBaseService.pb;
  final _searchController = TextEditingController();
  RecipesListPage? _recipesListPage;

  Future<List<RecipeModel>> search() async {
    final records = await PocketBaseService.pb.collection("recipes").getList(filter: "title ~ \"${_searchController.text}\"");
    List<RecipeModel> recipes = [];
    for(int i = 0; i < records.items.length; ++i) {
        recipes.add(RecipeModel.fromJson(records.items[i].toJson()));
    }
    return recipes;
  }

  void drawRecipes() {
    _recipesListPage = RecipesListPage(recipes: search());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
            controller: _searchController,
            onSubmitted: (value) => {drawRecipes()},
            decoration: InputDecoration(
              hintText: 'Поиск',
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(8.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.blue),
              ),
            ),
          ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 20.0),
                child: _recipesListPage == null ? Container() : _recipesListPage!,
                ),
            ),
          ],
        ),
      ),
    );
  }
}





