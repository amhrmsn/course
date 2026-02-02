// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_emertech/class/request.dart';
import 'package:project_emertech/main.dart';

class ContactRequest extends StatefulWidget {
  const ContactRequest({super.key});

  @override
  State<ContactRequest> createState() => _ContactRequestState();
}

class _ContactRequestState extends State<ContactRequest> {
  List<Request> requests = [];
    
  void doApproved(int id) async {
    final response = await http.post(
      Uri.parse("https://ubaya.cloud/flutter/160421077/UAS/approve_request_friend.php"),
      body: {
        'id': id.toString(),
      }
    );
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        bacaData();
      } 
    } else {
      throw Exception('Failed to load API');
    }
  }

  void doRejected(int id) async {
    final response = await http.post(
      Uri.parse("https://ubaya.cloud/flutter/160421077/UAS/reject_request_friend.php"),
      body: {
        'id': id.toString(),
      }
    );
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        bacaData();
      } 
    } else {
      throw Exception('Failed to load API');
    }
  }

  Future<String> fetchData() async {
    final response = await http.post(
      Uri.parse("https://ubaya.cloud/flutter/160421077/UAS/fetch_request.php"),
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
        requests.clear();
        for (var slice in json['data']) {
          requests.add(Request.fromJson(slice));
        }
      } else {
        requests.clear();
      }
      setState(() {
      });
    });
  }

  List<Widget> listContactCard(BuildContext context) {
    List<Widget> list = [];
    for (var contact in requests) {
      Widget w = Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1),
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 2)],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(              
                  padding: EdgeInsetsGeometry.all(10),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      "https://ubaya.cloud/flutter/160421077/UAS/${contact.photo}",
                    ),
                    backgroundColor: Colors.grey[300],
                  ),
                ),
                //rconst SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                                            Padding(
                        padding: EdgeInsetsGeometry.only(
                          top: 10, 
                          left: 15,
                          bottom: 10,
                        ),
                        child: Text(
                          "NRP: ${contact.id}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.only(
                          top: 10, 
                          left: 15,
                          bottom: 10,
                        ),
                        child: Text(
                          contact.fullname,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      //const SizedBox(height: 4),
                      Padding(
                        padding: EdgeInsetsGeometry.only(
                          top: 10,
                          left: 15,
                          bottom: 10,
                        ),
                        child: Text(
                          "NRP: ${contact.nrp}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      //const SizedBox(height: 4),
                      Padding(
                        padding: EdgeInsetsGeometry.only(
                          top: 10,
                          left: 15,
                          bottom: 10,
                        ),
                        child: Text(
                          contact.program,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      doApproved(contact.id);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Terima",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      doRejected(contact.id);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Tolak"),
                  ),
                ),
              ],
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