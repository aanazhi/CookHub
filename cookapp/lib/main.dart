//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor:  const Color.fromARGB(255, 148, 205, 120),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


   @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/png/chef.png", width: 220, height: 170),
              const SizedBox(height: 20),
              const Text(
                "Добро пожаловать в \n Cook HUB!",
                textAlign : TextAlign.center, 
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(221, 255, 255, 255)),
              ),
              Padding(
                padding : const EdgeInsets.fromLTRB(30, 30, 30, 5),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: const Color.fromARGB(221, 255, 255, 255),
                    filled: true,
                     border: InputBorder.none,
                       enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none, 
                      ),
                  ),
                ),
              ),
              Padding(
                padding : const EdgeInsets.fromLTRB(30, 30, 30, 30),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration:  InputDecoration(
                    hintText: 'Пароль',
                    fillColor: const Color.fromARGB(221, 255, 255, 255),
                    filled: true,
                    border: InputBorder.none,
                       enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none, 
                      ),
                    ),
                  ),
                ),
            
              ElevatedButton(
                onPressed: () {
                  //print('Email: ${_emailController.text}, Пароль: ${_passwordController.text}');
                },
                 style: ElevatedButton.styleFrom(
                     minimumSize: const Size(150, 50), 
                ),
                child: const Text('Войти',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                  color:   Color.fromARGB(255, 148, 205, 120))),
              ),
              const Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    SizedBox(height: 15),
    Text(
      "Нет аккаунта?",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(221, 255, 255, 255),
      ),
    ),
    InkWell(
      //onTap: () {},
      child: Text(
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
)
            
        
          




        ]
        ),
  
      ),
      )
    );
  }
}
      

