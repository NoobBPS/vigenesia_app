import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Ganti Base URL
  String baseurl =
      'https://78d4-103-108-130-37.ngrok-free.app/vigenesia'; // ganti dengan ip address kamu / tempat kamu menyimpan backend

  Future postRegister(
      String nama, String profesi, String email, String password) async {
    var dio = Dio();

    dynamic data = {
      "nama": nama,
      "profesi": profesi,
      "email": email,
      "password": password
    };

    try {
      final response = await dio.post("$baseurl/api/registrasi/",
          data: data,
          options: Options(headers: {'Content-type': 'application/json'}));

      print("Respon -> ${response.data} + ${response.statusCode}");

      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print("Failed To Load $e");
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController profesiController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100], // Tambahkan ini
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Register Your Account",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.black, // Warna teks diatur ke hitam
                    ),
                  ),
                  SizedBox(height: 50),
                  FormBuilderTextField(
                    name: "name",
                    controller: nameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      border: OutlineInputBorder(),
                      labelText: "Nama",
                      labelStyle: TextStyle(color: Colors.black), // Warna label diatur ke hitam
                    ),
                    style: TextStyle(color: Colors.black), // Warna teks diatur ke hitam
                  ),
                  SizedBox(height: 20),
                  FormBuilderTextField(
                    name: "profesi",
                    controller: profesiController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      border: OutlineInputBorder(),
                      labelText: "Profesi",
                      labelStyle: TextStyle(color: Colors.black), // Warna label diatur ke hitam
                    ),
                    style: TextStyle(color: Colors.black), // Warna teks diatur ke hitam
                  ),
                  SizedBox(height: 20),
                  FormBuilderTextField(
                    name: "email",
                    controller: emailController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      border: OutlineInputBorder(),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.black), // Warna label diatur ke hitam
                    ),
                    style: TextStyle(color: Colors.black), // Warna teks diatur ke hitam
                  ),
                  SizedBox(height: 20),
                  FormBuilderTextField(
                    obscureText: true,
                    name: "password",
                    controller: passwordController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      border: OutlineInputBorder(),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.black), // Warna label diatur ke hitam
                    ),
                    style: TextStyle(color: Colors.black), // Warna teks diatur ke hitam
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        await postRegister(
                                nameController.text,
                                profesiController.text,
                                emailController.text,
                                passwordController.text)
                            .then((value) => {
                                  if (value != null)
                                    {
                                      setState(() {
                                        Navigator.pop(context);
                                        Flushbar(
                                          message: "Berhasil Registrasi",
                                          duration: Duration(seconds: 2),
                                          backgroundColor: Colors.greenAccent,
                                          flushbarPosition: FlushbarPosition.TOP,
                                          messageColor: Colors.black, // Warna pesan diatur ke hitam
                                        ).show(context);
                                      })
                                    }
                                  else if (value == null)
                                    {
                                      Flushbar(
                                        message: "Check Your Field Before Register",
                                        duration: Duration(seconds: 5),
                                        backgroundColor: Colors.redAccent,
                                        flushbarPosition: FlushbarPosition.TOP,
                                        messageColor: Colors.black, // Warna pesan diatur ke hitam
                                      ).show(context)
                                    }
                                });
                      },
                      child: Text(
                        "Daftar",
                        style: TextStyle(color: Colors.black), // Warna teks diatur ke hitam
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
