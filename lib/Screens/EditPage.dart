// ignore_for_file: file_names

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_form_builder/flutter_form_builder.dart';

class EditPage extends StatefulWidget {
  final String? id;
  // ignore: non_constant_identifier_names
  final String? isi_motivasi;
  // ignore: non_constant_identifier_names
  const EditPage({super.key, this.id, this.isi_motivasi, required String userid, required String idMotivasi, String? isiMotivasi});

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
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${widget.isi_motivasi}"),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: FormBuilderTextField(
                      name: "isi_motivasi",
                      controller: isiMotivasiC,
                      decoration: InputDecoration(
                        labelText: "New Data",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        putPost(isiMotivasiC.text, widget.id.toString())
                            .then((value) => {
                                  if (value != null)
                                    {
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
          )),
    );
  }
}
