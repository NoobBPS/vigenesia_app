// ignore_for_file: file_names, depend_on_referenced_packages, duplicate_ignore, deprecated_member_use

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_form_builder/flutter_form_builder.dart';
// ignore: unused_import

class EditPage extends StatefulWidget {
  final String? id;
  // ignore: non_constant_identifier_names
  final String? isi_motivasi;
  // ignore: non_constant_identifier_names
  final Function? onUpdate; // Add this line
  // ignore: non_constant_identifier_names
  const EditPage({super.key, this.id, this.isi_motivasi, required String userid, required String idMotivasi, String? isiMotivasi, this.onUpdate}); // Modify this line

  @override
  // ignore: library_private_types_in_public_api
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String baseurl =
      'http://localhost/vigenesia/'; // ganti dengan ip address kamu / tempat kamu menyimpan backend

  var dio = Dio();
  Future<dynamic> putPost(String isiMotivasi, String ids) async {
    Map<String, dynamic> data = {"isi_motivasi": isiMotivasi, "id": ids};
    var response = await dio.put('$baseurl/api/dev/PUTmotivasi',
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ));

    return response.data;
  }

  TextEditingController isiMotivasiC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromRGBO(38, 0, 255, 1), Color.fromRGBO(0, 0, 0, 1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ignore: unnecessary_string_interpolations
                    Text("${widget.isi_motivasi ?? 'Edit Motivasi'}",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3, // Adjusted width
                      child: FormBuilderTextField(
                        name: "isi_motivasi",
                        controller: isiMotivasiC,
                        decoration: InputDecoration(
                          labelText: "Masukkan data baru",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          filled: true, // Enable filling
                          fillColor: Colors.white, // Set background color to white
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          putPost(isiMotivasiC.text, widget.id.toString())
                              .then((value) => {
                                    if (value != null)
                                      {
                                        if (widget.onUpdate != null) widget.onUpdate!(), // Call the callback
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context), 
                                        Flushbar(
                                          message: "Berhasil Update & Refresh dlu",
                                          duration: Duration(seconds: 5),
                                          backgroundColor: Colors.green,
                                          flushbarPosition: FlushbarPosition.TOP,
                                          // ignore: use_build_context_synchronously
                                        ).show(context)
                                      }
                                  });
                        },
                        child: Text("Submit"))
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
