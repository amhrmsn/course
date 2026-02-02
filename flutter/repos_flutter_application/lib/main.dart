import 'package:flutter/material.dart';
import 'package:flutter_application_1/addrecipe.dart';
import 'about.dart';
import 'basket.dart';
import 'home.dart';
import 'search.dart';
import 'history.dart';
import 'class/quiz.dart';
import 'login.dart';
import 'animasi.dart';
import 'package:shared_preferences/shared_preferences.dart';

String active_user = "";

Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String userId = prefs.getString("user_id") ?? '';
  return userId;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  checkUser().then((String result) {
    if (result == '') {
      runApp(MyLogin());
    } else {
      active_user = result;
      runApp(MyApp());
    }
  });
}

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
      routes: {
  			   'about': (context) => const About(),
           'basket': (context) => Basket(),
           'add_recipe': (context) => AddRecipe(),
           'quiz': (context) => Quiz(),
           'animasi': (context) => Animasi()
   		},
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
  int _counter = 0;
  String emoji = "";
  int _currentIndex = 0;

  Future<bool> doLogout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("user_id");
    return true;
  }

  final List<Widget> _screens = [
    Home(), 
    Search(), 
    History()
  ];

  final List<String> _title = [
    'Home', 
    'Search', 
    'History'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser().then((value) {
      setState(() {
        active_user = value;
      });
    });
  }

  void _incrementCounter() {
    setState(() {
      StringBuffer buffer = StringBuffer();
      _counter++;
      for (int i = 1; i <= _counter; i++) {
        if (_counter%5 == 0 && _counter <= 15) {
          buffer.write('\u{1F621}');
        } else {
          buffer.write('\u{1F600}');
        }
      }
      emoji = buffer.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:  Text(_title[_currentIndex]),
      ),
      /*body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              emoji,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '160421077',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Amirullah Heryanto Muslan',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),*/
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      drawer: myDrawer(),
      persistentFooterButtons: <Widget>[
        ElevatedButton(
          onPressed: () {},
          child: const Icon(Icons.skip_previous),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Icon(Icons.skip_next),
        ),
      ],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        fixedColor: Colors.teal,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "History",
            icon: Icon(Icons.history),
          ),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Drawer myDrawer() {
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Amirullah Heryanto Muslan"), 
            accountEmail: Text(active_user),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
            ),
          ),
          ListTile(
            title: const Text("Inbox"),
            leading: const Icon(Icons.inbox),
            onTap: () {},
          ),
          ListTile(
            title: const Text("About"),
            leading: const Icon(Icons.help),
            onTap: () {
              /*Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const About()),
              );*/
              Navigator.pushNamed(context, "about");
            },
          ),
          ListTile(
            title: const Text("My Basket"),
            leading: const Icon(Icons.shopping_basket),
            onTap: () {
              Navigator.pushNamed(context, "basket");
            },
          ),
          ListTile(
            title: const Text("Quiz"),
            leading: const Icon(Icons.question_answer),
            onTap: () {
              Navigator.pushNamed(context, "quiz");
            },
          ),
          ListTile(
            title: const Text("Add Recipe"),
            leading: const Icon(Icons.add),
            onTap: () {
              Navigator.pushNamed(context, "add_recipe");
            },
          ),
          ListTile(
            title: const Text("Animasi"),
            leading: const Icon(Icons.animation),
            onTap: () {
              Navigator.pushNamed(context, "animasi");
            },
          ),
          ListTile(
            title: const Text("Logout"),
            leading: const Icon(Icons.logout),
            onTap: () {
              doLogout().then((v) {
                main();
              });
            },
          ),
        ],
      ),
    );
  }
}
