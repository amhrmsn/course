import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/image.png", fit: BoxFit.cover)
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/hitler.png"),
                      fit: BoxFit.cover
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 34.0), // margin kanan-kiri
                  child: Text(
                    "“It Is Better To Make A Mistake Then To Do Nothing.”",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20, 
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    color: Colors.white, // biar elegan kalau ada background
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                    padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '- Adolf H',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}