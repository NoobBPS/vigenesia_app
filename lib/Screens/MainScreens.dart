

  // ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_form_builder/flutter_form_builder.dart';
// ignore: unused_import
import 'package:vigenesia/Screens/EditPage.dart';
import 'package:vigenesia/Screens/Login.dart';
import '../Models/Motivasi_Model.dart';

class MainScreens extends StatefulWidget {
  final String? nama;
  final String? iduser;

  const MainScreens({super.key, this.nama, this.iduser});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreens> {
  String baseurl = 'http://localhost/vigenesia/';

  String? id;
  var dio = Dio();
  TextEditingController titleController = TextEditingController();

  Future<dynamic> sendMotivasi(String Motivasi) async {
    Map<String, dynamic> body = {
      "isi_motivasi": Motivasi,
      "iduser": widget.iduser ?? ''
    };

    try {
      final response = await dio.post("$baseurl/api/dev/POSTmotivasi",
          data: body,
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
          ));

      return response;
    } catch (e) {
      // Handle error
    }
  }

  List<MotivasiModel> listproduk = [];

  Future<List<MotivasiModel>> getData() async {
    var response = await dio.get('$baseurl/api/Get_motivasi/');

    if (response.statusCode == 200) {
      var getUserData = response.data as List;
      var listUsers =
          getUserData.map((i) => MotivasiModel.fromJson(i)).toList();
      return listUsers;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<dynamic> deletePost(String id) async {
    dynamic data = {
      "id": id,
    };
    var response = await dio.delete('$baseurl/api/dev/DELETEmotivasi',
        data: data,
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: {"Content-type": "application/json"}));
    var resbody = jsonDecode(response.data);
    return resbody;
  }

  Future<void> _getData() async {
    final data = await getData();
    setState(() {
      listproduk = data;
    });
  }

  TextEditingController isiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromRGBO(38, 0, 255, 1), Color.fromRGBO(0, 0, 0, 1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(left: 340.0, right: 340.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 110),
                    Text(
                      "Masukkan Motivasi",
                      style: TextStyle(
                        fontFamily: 'Montserrat', // Use Montserrat font
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Colors.black, // Set background color to black
                          child: Text(
                            "Hallo ${widget.nama} 😊",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white, // Change text color to white
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => Login(),
                                  ),
                                );
                              },
                              child: Icon(Icons.logout, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 110),
                    Center(
                      child: Image.asset(
                        'assets/images/pic1.jpg',
                        width: 501,
                        height: 501,
                      ),
                    ),
                    SizedBox(height: 50),
                    SizedBox(
                      width: 500,
                      child: FormBuilderTextField(
                        controller: isiController,
                        name: "isi_motivasi",
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    SizedBox(
                      width: 500,
                      child: ElevatedButton(
                        onPressed: () async {
                          await sendMotivasi(isiController.text.toString())
                              .then((value) => {
                                    if (value != null)
                                      {
                                        Flushbar(
                                          message: "Berhasil Submit",
                                          duration: Duration(seconds: 2),
                                          backgroundColor: Colors.greenAccent,
                                          flushbarPosition: FlushbarPosition.TOP,
                                        ).show(context)
                                      },
                                    _getData(),
                                    print("Sukses"),
                                  });
                        },
                        child: Text("Submit"),
                      ),
                    ),
                    SizedBox(height: 40),
                    TextButton(
                      onPressed: () {
                        _getData();
                      },
                      child: Icon(Icons.refresh, color: Colors.white), // Change icon color to white
                    ),
                    SizedBox(height: 50),
                    FutureBuilder(
                      future: getData(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<MotivasiModel>> snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              for (var item in snapshot.data!)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  margin: EdgeInsets.only(bottom: 20), // Add margin for spacing
                                  padding: EdgeInsets.all(10), // Add padding inside the container
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.isiMotivasi.toString(),
                                            style: TextStyle(
                                              fontFamily: 'Lato', // Use Lato font for isiMotivasi
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "Tanggal Input: ${item.tanggalInput?.toLocal().toString().split(' ')[0]}",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Lato', // Use Lato font for date input
                                            ),
                                          ),
                                          Text(
                                            "Tanggal Update: ${item.tanggalUpdate ?? 'Belum diperbarui'}",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Lato', // Use Lato font for date update
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          TextButton(
                                            child: Icon(Icons.edit, color: Colors.yellow),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (BuildContext context) =>
                                                      EditPage(
                                                        id: item.id,
                                                        isiMotivasi: item.isiMotivasi,
                                                        userid: '',
                                                        idMotivasi: '',
                                                      ),
                                                ));
                                            },
                                          ),
                                          TextButton(
                                            child: Icon(Icons.delete, color: Colors.red),
                                            onPressed: () {
                                              deletePost(item.id!).then((value) => {
                                                if (value != null) {
                                                  Flushbar(
                                                    message: "Berhasil Delete",
                                                    duration: Duration(seconds: 2),
                                                    backgroundColor: Colors.redAccent,
                                                    flushbarPosition: FlushbarPosition.TOP,
                                                  ).show(context)
                                                }
                                              });
                                              _getData();
                                            },
                                          )
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                            ],
                          );
                        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                          return Text("No Data");
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
