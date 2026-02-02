// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_emertech/main.dart';
import 'package:project_emertech/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _errorRegister = ""; 
  bool _obscureText = true;
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _nrpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _basicCheckPasswordController = TextEditingController();

  void doRegister() async {
    if (_fullnameController.text == "") {
      _errorRegister = "Masukan nama lengkap";
      return;
    }
    if (_nrpController.text == "") {
      _errorRegister = "Masukan NRP";
      return;
    }
    if (_emailController.text == "") {
      _errorRegister = "Masukan email";
      return;
    }
    if (_passwordController.text.length < 6) {
      _errorRegister = "Password minimal 6 karakter";
      return;
    } 
    if (_passwordController.text != _basicCheckPasswordController.text) {
      _errorRegister = "Password tidak sama";
      return;
    } 
    final response = await http.post(
      Uri.parse("https://ubaya.cloud/flutter/160421077/UAS/register.php"),
      body: {
        'email' : _emailController.text,
        'password' : _passwordController.text, 
        'fullname' : _fullnameController.text, 
        'nrp': _nrpController.text,
      },
    );
    if (response.statusCode == 200) {
      Map unmarshalJson = jsonDecode(response.body);
      if (unmarshalJson['result'] == 'success') {
        final sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('email', _emailController.text);
        main();
      } else {
        _errorRegister = unmarshalJson['message'];
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

    @override
  void initState() {
    super.initState();
    _errorRegister = "";
    _fullnameController.text = "";
    _nrpController.text = "";
    _emailController.text = "";
    _passwordController.text = "";
    _basicCheckPasswordController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: 1),
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 2)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 20.0,
                  ),
                  child: Text(
                    "Buat akun baru",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Nama Lengkap",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _fullnameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Masukkan nama lengkap',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "NRP",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _nrpController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder()
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(9)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'nama@email.com',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Minimal 6 karakter',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Konfirmasi Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _basicCheckPasswordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Masukkan password lagi',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          doRegister();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.black,
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sudah punya akun? ",
                        style: TextStyle(fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: const Text(
                          "Login di sini",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
       		          _errorRegister,
         		        style: const TextStyle(color: Colors.red),
                  )
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}