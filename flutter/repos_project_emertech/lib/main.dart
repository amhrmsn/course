// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_emertech/login.dart';
import 'package:project_emertech/edit_profil.dart';
import 'package:project_emertech/daftar_mahasiswa.dart';
import 'package:project_emertech/daftar_request.dart';
import 'package:project_emertech/daftar_contacts.dart';

String activeEmail = "";
String activeFullname = "";
String activePhoto = "";
String? activeProgram;
String? activeBiografi;

Future<String> doCheckUser() async {
  final preferences = await SharedPreferences.getInstance();
  activeEmail = preferences.getString("email") ?? "";
  return activeEmail;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  doCheckUser().then((String value) {
    if (value == "") {
      runApp(MyLogin());
    } else {
      runApp(MyApp());
    }
  });
}

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screen = [
    DaftarMahasiswa(),
    EditProfile(),
    Contacts(),
    ContactRequest(),
  ];

  final List<String> _title = [
    'Daftar Mahasiswa',
    'Edit Profil',
    'Daftar Kontak',
    'Permintaan Koneksi',
  ];

  Future<bool> doLogout() async {
    await showDialog(
      context: context, 
      builder: (BuildContext context) => AlertDialog(
        title: Text('Berhasil'),
        content: Text('Anda telah LOGOUT'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK"),
          )
        ],
      ),
    );
    final preferences = await SharedPreferences.getInstance();
    preferences.remove("email");
    return true;
  }

  Future<String> fetchData() async {
    final response = await http.post(
      Uri.parse("https://ubaya.cloud/flutter/160421077/UAS/fetch_active_user.php"),
      body: {
        "email": activeEmail,
      }
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load API');
    }
  }

  void bacaData() {
    Future<String> data = fetchData();
    data.then((value) {
      Map json = jsonDecode(value);
      if (json['result'] == 'success') {
        setState(() {
          activeFullname = json['fullname'] ?? "";
          activePhoto    = json['photo'] ?? "";
          activeProgram  = json['program'] ?? "";
          activeBiografi = json['biografi'] ?? "";
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          _title[_currentIndex],
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: _screen[_currentIndex],
      drawer: myDrawer(),
    );
  }

  Drawer myDrawer() {
    return Drawer(
      elevation: 16.0,
      backgroundColor: Colors.white,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              activeFullname,
              style: TextStyle(
                color: Colors.black
              ),
            ), 
            accountEmail: Text(
              activeEmail,
              style: TextStyle(
                color: Colors.black
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage("https://ubaya.cloud/flutter/160421077/UAS/$activePhoto"),
            ),
            decoration: BoxDecoration(
              color: Colors.white
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsetsGeometry.all(20),
              child: Text(
                "Menu",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          ListTile(
            title: Text("Home"),
            leading: Icon(Icons.home),
            onTap: () {
              setState(() {
                _currentIndex = 0;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Edit Profile"),
            leading: Icon(Icons.person_outline_outlined),
            onTap: () {
              setState(() {
                _currentIndex = 1;
              });
              Navigator.pop(context);
            },
          ),     
          ListTile(
            title: Text("Contacts"),
            leading: Icon(Icons.supervisor_account),
            onTap: () {
              setState(() {
                _currentIndex = 2;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Request"),
            leading: Icon(Icons.notifications),
            onTap: () {
              setState(() {
                _currentIndex = 3;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Logout"),
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onTap: () {
              doLogout().then((value) {
                main();
              });
            },
          )
        ],
      ),
    );
  }
}
