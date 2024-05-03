import 'package:cook/enter.dart';
import 'package:cook/service/PocketbaseService.dart';
import 'package:flutter/material.dart';



class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
 
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();



  @override
  void initState() {
    super.initState();
    _initializeName();
    _initializeAbout();
    _initializeEmail();

  }

  static const colorNew = Color.fromARGB(255, 148, 205, 120);

  final pb = PocketBaseService.pb;


    void _navigateToRegistrationPage(BuildContext context) {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

    Future<void> _initializeName() async {
    String name = await getName();
    setState(() {
      _nameController.text = name;
    });
  }

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


  Future<void> _initializeAbout() async {
    String about = await getAbout();
    setState(() {
      _aboutController.text = about;
    });
  }


  Future<void> updateUserName(String newName) async {
    try {
      final body = <String, dynamic>{
        "name": newName, 
      };

      final record = await pb.collection('users').update(pb.authStore.model.id, body: body);
      print("User name updated successfully: $record");
    } catch (e) {
      print("Failed to update user name: $e");
    }
  }


  Future<void> updateAbout(String newAbout) async {
    try {
      final body = <String, dynamic>{
        "about": newAbout, 
      };

      final record = await pb.collection('users').update(pb.authStore.model.id, body: body);
      print("User name updated successfully: $record");
    } catch (e) {
      print("Failed to update user name: $e");
    }
  }


  
  Future<void> updatePassword(String password) async {
    try {
      final body = <String, dynamic>{
        "about": password, 
      };

      final record = await pb.collection('users').update(pb.authStore.model.id, body: body);
      print("User name updated successfully: $record");
    } catch (e) {
      print("Failed to update user name: $e");
    }
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


  Future<void> _initializeEmail() async {
    String email = await getEmail();
    setState(() {
      _emailController.text = email;
    });
  }

   Future<String> getEmail() async {
    print(pb.authStore.model);
    final record =  await pb.collection('users').getOne(pb.authStore.model.id);
    //await pb.collection('users').delete(pb.authStore.model.id); // удаление пользователя
    // final records = await pb.collection('recipes').getFullList( // рецепты
    // sort: '-created',
    // );
    // print(records.length);
    final email = record.getDataValue<String>('email');  
    return email;
  }

  






    Future<bool> deleteUser() async {
    print(pb.authStore.model);
    final record =  await pb.collection('users').delete(pb.authStore.model.id); // удаление пользователя
    // final records = await pb.collection('recipes').getFullList( // рецепты
    // sort: '-created',
    // );
    // print(records.length);
  
    return true;
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(), // Возврат на предыдущий экран
        ),
      ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/png/camera.png", width: 200, height: 150, color: Colors.white,),
                //const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                  child: TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'Имя',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                  child: TextField(
                    controller: _aboutController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Описание',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                      fillColor: Colors.white, 
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                  child: TextField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: 'Новый пароль',
                      fillColor: Colors.white, 
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    updateUserName(_nameController.text);
                    updateAbout(_aboutController.text);
                    updatePassword(_passwordController.text);
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                    decoration: BoxDecoration(
                      color: Colors.white, 
                        borderRadius: BorderRadius.circular(10.0),  
                      ),
                      child: const Text("Сохранить изменения",
                        style: TextStyle(
                          color: colorNew,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                  )
                                 
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                  _navigateToRegistrationPage(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                    decoration: BoxDecoration(
                      color: Colors.white, 
                        borderRadius: BorderRadius.circular(10.0),  
                      ),
                      child: const Text("  Выйти из аккаунта  ",
                        style: TextStyle(
                          color: colorNew,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                  )
                                 
                ),
                
                const SizedBox(height: 20),
                GestureDetector(
                onTap: () async {
                  bool success = await deleteUser();
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Аккаунт успешно удален')),
                    );
                    _navigateToRegistrationPage(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ошибка при удалении аккаунта')),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
                    "   Удалить аккаунт   ",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
                const SizedBox(height: 30),             
              ],
            ),
          ),
        ),
      );
  }
}






