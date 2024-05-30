import 'package:cook/recipe_detail_page.dart';
import 'package:cook/search.dart';
import 'package:cook/recipes_list.dart';
import 'package:cook/add_recipe.dart';
import 'service/PocketbaseService.dart';
import 'package:cook/settings_screen.dart';
import 'package:flutter/material.dart';

class RecipeModel {
  final String id;
  final String title;
  final String description;
  final String instructions;
  final String photo;
  final int time;
  final String calorie;

  RecipeModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.instructions,
      required this.photo,
      required this.time,
      required this.calorie});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      instructions: json['instructions'],
      photo: json['photo'],
      time: json['time'],
      calorie: json['calorie'],
    );
  }
}

Future<List<RecipeModel>> getRecipes() async {
  final records = await PocketBaseService.pb.collection('recipes').getFullList(
        sort: '-created',
      );
  List<RecipeModel> recipes = [];
  for (int i = 0; i < records.length; ++i) {
    recipes.add(RecipeModel.fromJson(records[i].toJson()));
  }
  return recipes;
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int recipeCount = 0;
  final _searchPage = SearchPage();
  final _recipesListPage = RecipesListPage(recipes: getRecipes());
  final _addRecipePage = AddRecipePage();
  int _selectedIndex = 0;
  final pb = PocketBaseService.pb;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchRecipeCount();
  }

  Future<void> fetchRecipeCount() async {
    try {
      final result = await pb.collection("favorites").getList(
            filter: 'user_id ="${pb.authStore.model.id}"',
          );
      setState(() {
        recipeCount = result.totalItems;
      });
    } catch (err) {
      print('Error fetching recipe count: $err');
    }
  }

  static const colorNew = Color.fromARGB(255, 148, 205, 120);

  Future<String> getName() async {
    print(pb.authStore.model);
    final record = await pb.collection('users').getOne(pb.authStore.model.id);
    //await pb.collection('users').delete(pb.authStore.model.id); // удаление пользователя
    // final records = await pb.collection('recipes').getFullList( // рецепты
    // sort: '-created',
    // );
    // print(records.length);
    final name = record.getDataValue<String>('name');
    return name;
  }

  Future<String> getAbout() async {
    print(pb.authStore.model);
    final record = await pb.collection('users').getOne(pb.authStore.model.id);
    //await pb.collection('users').delete(pb.authStore.model.id); // удаление пользователя
    // final records = await pb.collection('recipes').getFullList( // рецепты
    // sort: '-created',
    // );
    // print(records.length);
    final about = record.getDataValue<String>('about');
    return about;
  }

  Widget _buildMainPage() {
    return SingleChildScrollView(
        child: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset("assets/png/chef.png", width: 100, height: 130),
        const SizedBox(height: 20),
        FutureBuilder<String>(
          future: getName(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              print("snap error");
              print(snapshot.error);
              return Text('Имя');
            } else {
              return Text(
                snapshot.data ?? 'Имя не найдено',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              );
            }
          },
        ),
        const SizedBox(height: 20),
        FutureBuilder<String>(
          future: getAbout(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              print("snap error");
              print(snapshot.error);
              return Text('Обо мне');
            } else {
              return Text(
                snapshot.data ?? 'Описание не найдено',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              );
            }
          },
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  recipeCount.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Рецепты",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Column(
              children: [
                Text(
                  "3",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Подписчики",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Column(
              children: [
                Text(
                  "1",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Подписки",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    )));
  }

  Widget _buildReceipePage() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List>(
        future:
            getRecipes(), // Убедитесь, что этот метод возвращает список рецептов
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
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
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.error),
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
                    '${recipe.calorie} ккал на 100 грамм',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailPage(recipe: recipe),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    height: 2,
                    color: Colors.green,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          } else {
            return Center(child: Text('Нет данных'));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorNew),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings, color: colorNew),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: _selectedIndex == 0
            ? _buildMainPage()
            : _selectedIndex == 1
                ? _searchPage
                : _selectedIndex == 2
                    ? _addRecipePage
                    : _selectedIndex == 4
                        ? _recipesListPage
                        : Container(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home, color: colorNew),
            label: 'Домой',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search, color: colorNew),
            label: 'Поиск',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add, color: colorNew),
            label: 'Добавить',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.star, color: colorNew),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/png/chef_hat.png",
                width: 20, height: 20, color: colorNew),
            label: 'Рецепты',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: colorNew,
        onTap: _onItemTapped,
      ),
    );
  }
}
