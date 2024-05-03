import 'package:cook/enter.dart';
import 'package:cook/main_page.dart';
import 'package:cook/service/PocketbaseService.dart';
import 'package:flutter/material.dart';

class YourRegistrationPage extends StatefulWidget {
  const YourRegistrationPage({super.key});

  @override
  _YourRegistrationPageState createState() => _YourRegistrationPageState();
}

class _YourRegistrationPageState extends State<YourRegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final pb = PocketBaseService.pb;

  void _navigateToRegistrationPage(BuildContext context) {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

  void _navigateToMainPage(BuildContext context) {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MainPage()),
    );
  }


  Future<bool> register(String email, String password) async {
    final Map<String, String> user = {"email": email, "password": password, "passwordConfirm": password};
    try {
      await pb.collection("users").create(body: user);
      await pb.collection("users").authWithPassword(email, password);
      return pb.authStore.isValid;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/png/pan.png", width: 180, height: 130),
              const SizedBox(height: 20),
              const Text(
                "Регистрация",
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
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
                child: TextField(
                  //controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Повтор пароля',
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
                  final isOk = await register(_emailController.text, _passwordController.text);
                  if (isOk) {
                    _navigateToMainPage(context);
                  } else { print("not registered"); }
                },
                  style: ElevatedButton.styleFrom(
                     minimumSize: const Size(150, 50), 
                ),
                child: const Text('Зарегистрироваться',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                  color:   Color.fromARGB(255, 148, 205, 120))),
              ),
              const SizedBox(height: 15),
              const Text(
                "Есть аккаунт?",
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
                  "Войти",
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







