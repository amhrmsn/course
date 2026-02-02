import 'package:flutter/material.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String active_user = "";
  final TextEditingController _emailController = TextEditingController();

  void doLogin() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user_id", _emailController.text);
    main();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text = "";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Container(
        height: 300,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1),
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 5)],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)),
               child: ElevatedButton(
                  onPressed: () {
                    doLogin();
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              )
            ),
          ]
        ),
      ),
    );
  }
}