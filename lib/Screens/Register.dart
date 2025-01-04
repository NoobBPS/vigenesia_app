

// ignore_for_file: file_names, use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_form_builder/flutter_form_builder.dart';
// ignore: unused_import

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Ganti Base URL
  String baseurl =
      'http://localhost/vigenesia/'; // ganti dengan ip address kamu / tempat kamu menyimpan backend

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

      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      // ignore: avoid_print
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 228, 6, 6), Color.fromARGB(255, 217, 255, 0)], // Blue to Purple
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 3.9,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Register Your Account",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white, // Warna teks diatur ke hitam
                      ),
                    ),
                    SizedBox(height: 50),
                    FormBuilderTextField(
                      name: "name",
                      controller: nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(left: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: "Nama",
                        labelStyle: TextStyle(color: Colors.black), // Warna label diatur ke hitam
                        hintText: "Masukkan Nama", // Placeholder
                        hintStyle: TextStyle(color: Colors.black), // Warna placeholder diatur ke putih
                      ),
                      style: TextStyle(color: Colors.black), // Warna teks diatur ke hitam
                    ),
                    SizedBox(height: 20),
                    FormBuilderTextField(
                      name: "profesi",
                      controller: profesiController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(left: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: "Profesi",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "Masukkan Profesi", // Placeholder
                        hintStyle: TextStyle(color: Colors.black), // Warna placeholder diatur ke putih
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    FormBuilderTextField(
                      name: "email",
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(left: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "Masukkan Email", // Placeholder
                        hintStyle: TextStyle(color: Colors.black), // Warna placeholder diatur ke putih
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    FormBuilderTextField(
                      obscureText: true,
                      name: "password",
                      controller: passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(left: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "Masukkan Password", // Placeholder
                        hintStyle: TextStyle(color: Colors.black), // Warna placeholder diatur ke putih
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 5.1,
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
                                            maxWidth: MediaQuery.of(context).size.width * 0.8, // Set max width to 80% of screen width
                                            isDismissible: true, // Allow dismissing the message
                                            flushbarStyle: FlushbarStyle.GROUNDED, // Style to prevent overflow
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
      ),
    );
  }
}
