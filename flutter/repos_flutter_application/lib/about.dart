import 'package:flutter/material.dart';
import 'dart:math';

class About extends StatelessWidget {
  const About({super.key});

  List<Widget> randomPhotos() {
    List<Widget> temp = [];
    int i = 0;
    final random = Random();

    while (i < 30) {
      int randomNumber = random.nextInt(1084) + 1;
      Widget w = Image.network(
        "https://picsum.photos/id/$randomNumber/200/200",
      );
      temp.add(w);
      i++;
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.yellow,
              alignment: Alignment.center,
              width: 200.0,
              height: 200.0,
              child: AspectRatio(
                aspectRatio: 4/1,
                child: Container(
                  color: Colors.red
                ),
              ),
            ),
            Container(
              color: Colors.cyan,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              height: 300,
              width: 300,
              child: Card(
                child: Text('Hello World!')
              ),
            ),
            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://i.pravatar.cc/400?img=60'),
                  fit: BoxFit.cover
                ),
                border: Border.all(
                  color: Colors.indigo,
                  width: 10,
                ),
                //shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(60)),
                boxShadow: [
                  BoxShadow(blurRadius: 30, color: Colors.black)
                ]
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network('https://i.pravatar.cc/100?img=1'),
                Image.network('https://i.pravatar.cc/100?img=2'),
                Image.network('https://i.pravatar.cc/100?img=3'),
              ],
            ),
            Divider(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network('https://i.pravatar.cc/100?img=4'),
                  Image.network('https://i.pravatar.cc/100?img=5'),
                  Image.network('https://i.pravatar.cc/100?img=6'),
                  Image.network('https://i.pravatar.cc/100?img=7'),
                  Image.network('https://i.pravatar.cc/100?img=8'),
                  Image.network('https://i.pravatar.cc/100?img=9'),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20)
                    ),
                    image: DecorationImage(
                      image: NetworkImage("https://placecats.com/neo/300/200"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    "../assets/images/missing.png",
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 500,
              child: GridView.count(
                crossAxisCount: 3,
                children: randomPhotos(),
              ),
            ),
          ],
        ),
      )
    );
  }
}