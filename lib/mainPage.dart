//import 'package:cookapp/enter.dart';
import 'dart:convert';

import 'package:cook/enter.dart';
import 'package:cook/service/PocketbaseService.dart';
import 'package:cook/settingsScreen.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
//import 'dart:convert';




class RecipeModel {
  final String title;
  final String description;
  final String instructions;
  final String photo;
  final int time;
  final String calorie;

  
  RecipeModel({required this.title, required this.description, required this.instructions, required this.photo, required this.time, required this.calorie});
  
  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      title: json['title'],
      description: json['description'],
      instructions: json['instructions'],
      photo: json['photo'],
      time : json['time'],
      calorie: json['calorie'],

    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  static const colorNew = Color.fromARGB(255, 148, 205, 120);

final pb = PocketBaseService.pb;

  Future<String> getName() async {
    print(pb.authStore.model);
    final record =  await pb.collection('users').getOne(pb.authStore.model.id);
    //await pb.collection('users').delete(pb.authStore.model.id); // удаление пользователя
    // final records = await pb.collection('recipes').getFullList( // рецепты
    // sort: '-created',
    // );
    // print(records.length);
    final name = record.getDataValue<String>('name');  
    return name;
  }

 Future<List<RecipeModel>> getReceipes() async {
  final records = await pb.collection('recipes').getFullList(
    sort: '-created',
  );
  List<RecipeModel> recipes = [];

  for(int i = 0; i < records.length; ++i) {
      recipes.add(RecipeModel.fromJson(records[i].toJson()));
  }
  //   List<RecipeModel> recipes = records.map<RecipeModel>((record) {
  //   return RecipeModel.fromJson(record as Map<String, dynamic>);
  // }).toList();

  return recipes;
}




  
  Future<String> getAbout() async {
    print(pb.authStore.model);
    final record =  await pb.collection('users').getOne(pb.authStore.model.id);
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
                  return Text(snapshot.data ?? 'Имя не найдено',
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
                  return Text(snapshot.data ?? 'Описание не найдено',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              },
            ),
 
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("0",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),),
                      Text("Рецепты",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                  Column(
                    children: [
                      Text("0",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),),
                      Text("Подписчики",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                  Column(
                    children: [
                      Text("0",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),),
                      Text("Подписки",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
            )
          ],
        ),
          ],
      ))
    );
  }
  
Widget _buildReceipePage() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: FutureBuilder<List>(
      future: getReceipes(), 
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
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
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
    : _selectedIndex ==  4
      ?  _buildReceipePage()
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
            icon: Image.asset("assets/png/chef_hat.png", width: 20, height: 20, color: colorNew),
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







