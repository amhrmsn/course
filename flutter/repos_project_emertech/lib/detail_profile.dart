// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:project_emertech/class/profile.dart';
import 'package:project_emertech/main.dart';

class DetailProfile extends StatelessWidget {
  final Profile profile;
  const DetailProfile(this.profile, {super.key});

  void doRequest(BuildContext context , String email) async {
    if (activeEmail == email) {
      showDialog(
        context: context, 
        builder: (BuildContext context) => AlertDialog(
          title: Text('Berhasil'),
          content: Text("Tidak bisa koneksi ke akun sendiri"),
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
    }
    final response = await http.post(
      Uri.parse("https://ubaya.cloud/flutter/160421077/UAS/request_friend.php"),
      body: {
        'contact_request': activeEmail, 
        'contact_to': email,
      }
    );
    if (response.statusCode == 200) {
      Map res = jsonDecode(response.body);
      showDialog(
        context: context, 
        builder: (BuildContext context) => AlertDialog(
          title: Text('Berhasil'),
          content: Text(res['message']),
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
    } else {
      throw Exception('Failed to load API');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Detail Mahasiswa",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          doRequest(context, profile.email);
        },
        shape: CircleBorder(),
        child: Icon(Icons.person_add_alt),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: 1),
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 2)
              ],
            ),
            child: Column(
              children: [
                Padding(              
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://ubaya.cloud/flutter/160421077/UAS/${profile.photo}"),
                        fit: BoxFit.cover
                      ),
                      shape: BoxShape.circle
                    ),                    
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Text(
                    profile.fullname,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.5,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Text(
                    "NRP: ${profile.nrp}",
                    style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 2.5,
                    left: 2.5,
                    top: 20
                  ),
                  child: Container(
                    width: double.infinity,
                      padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromARGB(255, 218, 222, 218),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Program/Lab",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 5
                            ),
                            child: Text(
                              profile.program ?? "",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w100
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 2.5,
                    left: 2.5,
                    top: 20
                  ),
                  child: Container(
                    width: double.infinity,
                      padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromARGB(255, 218, 222, 218),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Biografi",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                              bottom: 5
                            ),
                            child: Text(
                              profile.biografi ?? "",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w100
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}