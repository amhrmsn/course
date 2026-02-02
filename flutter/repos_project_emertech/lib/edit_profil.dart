// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_emertech/main.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _biografiController = TextEditingController();
  String _programCategory = "";

  void doUpdate() async {
    final response = await http.post(
      Uri.parse("https://ubaya.cloud/flutter/160421077/UAS/update_active_user.php"),
      body: {
        'fullname': _fullnameController.text,
        'program': _programCategory,
        'biografi': _biografiController.text,
        'email': activeEmail, 
      }
    );
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        main();
      } 
    } else {
      throw Exception('Failed to read API');
    }
  }

  @override
  void initState() {
    super.initState();
    _fullnameController.text = activeFullname;
    _programCategory = activeProgram ?? "";
    _biografiController.text = activeBiografi ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
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
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    bottom: 15.0
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Edit Informasi Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    bottom: 2.5
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
                  padding: EdgeInsets.only(
                    left: 10
                  ),
                  child: TextField(
                    controller: _fullnameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15.0,
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Program/Lab",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                ),
                Padding(             
                  padding: EdgeInsets.only(
                    left: 10,
                    top: 2.5
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 15
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(
                          value: "",
                          child: Text("Pilih"),
                        ),
                        DropdownMenuItem(
                          value: "Teknik Informatika",
                          child: Text("Teknik Informatika"),
                        ),
                        DropdownMenuItem(
                          value: "Farmasi",
                          child: Text("Farmasi")
                        ),
                        DropdownMenuItem(
                          value: "Psikologi",
                          child: Text("Psikologi")
                        )
                      ], 
                      value: _programCategory,
                      onChanged: (value) {
                        setState(() {
                          _programCategory = value!;
                        }
                      );},
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15.0,
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Biografi",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10
                  ),
                  child: TextField(
                    controller: _biografiController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 4,
                    maxLines: null,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _fullnameController.text = "";
                            _programCategory = "";
                            _biografiController.text = "";
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyApp())
                            );
                          }, 
                          child: Text("Batal")
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              doUpdate();
                            });
                            showDialog(
                              context: context, 
                              builder: (BuildContext context) => AlertDialog(
                                title: Text('Edit Profile'),
                                content: Text('Edit profile successfully'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context, 
                                          MaterialPageRoute(builder: (context) => MyApp())
                                        );
                                      },
                                    child: Text("OK"),
                                  )
                                ],
                              )
                            );
                          }, 
                          child: Text("Simpan Perubahan")
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}