import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:org/Screens/EditPage.dart';
import 'package:org/Screens/Login.dart';

import '../Models/Motivasi_Model.dart';

class MainScreens extends StatefulWidget {
  final String? nama;
  final String? iduser;

  const MainScreens({Key? key, this.nama, this.iduser}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreens> {
  String baseurl = 'https://78d4-103-108-130-37.ngrok-free.app/vigenesia';

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
            //validateStatus: (status) => true,
          ));

      print("Respon -> ${response.data} + ${response.statusCode}");
      return response;
    } catch (e) {
      print("error di -> $e");
    }
  }

  List<MotivasiModel> listproduk = [];

  Future<List<MotivasiModel>> getData() async {
    var response = await dio.get('$baseurl/api/Get_motivasi/');

    print(" ${response.data}");
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
    print("${response.data}");
    var resbody = jsonDecode(response.data);
    return resbody;
  }

  Future<void> _getData() async {
    setState(() {
      _getData();
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(

            height: MediaQuery.of(context).size.height, // Mengatur tinggi container
            color: Color(0xFF13B4FF), // Mengatur warna latar belakang

            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 1,
                    ),
                    Text(
                    "Masukkan Motivasi",
                    style: TextStyle(
                      color: Colors.white, // Mengubah warna teks judul
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hallo ${widget.nama}",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
                          child: Icon(Icons.logout),
                        ),
                      ],
                    ),
                    
              SizedBox(height: 20),
                  Container(
                    width: 500,
                    child: FormBuilderTextField(
                    controller: isiController,
                    name: "isi_motivasi",
                    decoration: InputDecoration(
                      filled: true, // Mengaktifkan pengisian latar belakang
                      fillColor: Colors.white, // Mengatur warna latar belakang menjadi putih 
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Mengatur warna border menjadi putih
                      ),
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                  ),
                  ),

                    SizedBox(height: 40),
                    Container(
                      width: MediaQuery.of(context).size.width,
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
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                          ).show(context)
                                        },
                                      _getData(),
                                      print("Sukses"),
                                    });
                          },
                          child: Text("Submit")),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextButton(
                        onPressed: () {
                          _getData();
                        },
                        child: Icon(Icons.refresh)),
                    FutureBuilder(
                        future: getData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<MotivasiModel>> snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                for (var item in snapshot.data!)
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        //Expanded(
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(item.isiMotivasi.toString()),
                                            Row(
                                              children: [
                                                TextButton(
                                                  child: Icon(Icons.settings),
                                                  onPressed: () {
                                                    //String id;
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              EditPage(
                                                                  id: item.id,
                                                                  isiMotivasi: item
                                                                      .isiMotivasi),
                                                        ));
                                                  },
                                                ),
                                                TextButton(
                                                  child: Icon(Icons.delete),
                                                  onPressed: () {
                                                    deletePost(item.id!)
                                                        .then((value) => {
                                                              if (value != null)
                                                                {
                                                                  Flushbar(
                                                                    message:
                                                                        "Berhasil Delete",
                                                                    duration: Duration(
                                                                        seconds:
                                                                            2),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .redAccent,
                                                                    flushbarPosition:
                                                                        FlushbarPosition
                                                                            .TOP,
                                                                  ).show(
                                                                      context)
                                                                }
                                                            });
                                                    _getData();
                                                  },
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        //),
                                      ],
                                    ),
                                  ),
                              ],
                            );
                          } else if (snapshot.hasData &&
                              snapshot.data!.isEmpty) {
                            return Text("No Data");
                          } else {
                            return CircularProgressIndicator();
                          }
                        })
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
