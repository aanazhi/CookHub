import 'package:flutter/material.dart';
import 'package:cook/registration.dart';
import 'package:cook/mainPage.dart';
import 'package:cook/service/PocketbaseService.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final pb = PocketBaseService.pb;

  

  Future<bool> authenticateUser(String email, String password) async {
    await pb.collection("users").authWithPassword(email, password);
    return pb.authStore.isValid;
}


  void _navigateToRegistrationPage(BuildContext context) {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => YourRegistrationPage()),
    );
  }


    void _navigateToMainPage(BuildContext context) {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MainPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/png/cooking.png", width: 220, height: 170),
              const SizedBox(height: 22),
              const Text(
                "Добро пожаловать в \n Cook HUB!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, 
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
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
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Пароль',
                    fillColor: Colors.white, 
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
              onPressed: () async {
                bool isAuthenticated = await authenticateUser(
                  _emailController.text,
                  _passwordController.text,
                );
                if (isAuthenticated) {
                  
                  _navigateToMainPage(context);

                } else {
                  print('Неверный логин или пароль');
                }
              },
                child: const Text('Войти',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                  color:   Color.fromARGB(255, 148, 205, 120))),
              ),
              const SizedBox(height: 15),
              const Text(
                "Нет аккаунта?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(221, 255, 255, 255),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _navigateToRegistrationPage(context);
                },
                child: const Text(
                  "Зарегистрироваться",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(221, 255, 255, 255),
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                         ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





