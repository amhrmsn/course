// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_emertech/class/profile.dart';
import 'package:project_emertech/detail_profile.dart';
import 'package:project_emertech/main.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
   List<Profile> profiles = [];

  Future<String> fetchData() async {
    final response = await http.post(
      Uri.parse("https://ubaya.cloud/flutter/160421077/UAS/fetch_contacts.php"),
      body: {
        'email': activeEmail, 
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
      if (json['result']=='success') {
        for (var slice in json['data']) {
          profiles.add(Profile.fromJson(slice));
        }
      } else {
        profiles.clear();
      }
      setState(() {
      });
    });
  }

  List<Widget> listContactCard(BuildContext context) {
    List<Widget> list = [];
    for (var profile in profiles) {
      Widget w = Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1),
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 2)],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 5.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Text(
                profile.fullname,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            Padding(              
              padding: EdgeInsets.only(
                top: 2.5,
                left: 20.0,
                right: 20.0,
              ),
              child: Image.network(
                "https://ubaya.cloud/flutter/160421077/UAS/${profile.photo}",
                height: 120,
                width: 100,
                fit: BoxFit.cover,
              )
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
                  fontWeight: FontWeight.w100
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 15.0,
                left: 20.0,
                right: 20.0,
                bottom: 15.0, 
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailProfile(profile)
                      )
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'Lihat Detail Profil',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ),
          ],
        ),
      );
      list.add(w);
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: listContactCard(context),
          ),
        ),
      ),
    );
  }
}