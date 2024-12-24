// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigenesia/Models/Login_Model.dart';

import 'MainScreens.dart';
import 'Register.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with WidgetsBindingObserver {
  //Timer? timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  String? nama;
  String? iduser;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  Future<LoginModels?> postLogin(String email, String password) async {
    var dio = Dio();
    String baseurl = 'http://localhost/vigenesia/';
    LoginModels? model;

    Map<String, dynamic> data = {"email": email, "password": password};
    try {
      final response = await dio.post("$baseurl/api/login",
          data: data,
          options: Options(headers: {'Content-type': 'application/json'}));


      if (response.statusCode == 200) {
        model = LoginModels.fromJson(response.data);
      }
    } catch (e) {
      // ignore: avoid_print
      print("Failed to load $e");
    }

    return model;
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(left: 0, right: 0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            //jumlah stop berbanding lurus dengan jumlah warna
            stops: [0.3, 0.6, 0.9],
            colors: [
              Color.fromRGBO(12, 235, 235, 1),
              Color.fromRGBO(32, 227, 178, 1),
              Color.fromRGBO(41, 255, 198, 1),
            ],
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "VIGENESIA",
            style: GoogleFonts.montserrat(
                fontSize: 40, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          Text(
            "Visi Generasi Indonesia",
            style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 50),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              margin: const EdgeInsets.only(left: 0, right: 0),
              child: Form(
                key: _fbKey,
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  margin: const EdgeInsets.only(
                      top: 20, left: 50.0, right: 50.0, bottom: 20),
                  child: Column(
                    children: [
                      Text(
                        "LOGIN",
                        style: GoogleFonts.montserrat(
                            fontSize: 27,
                            fontWeight: FontWeight.w800,
                            color: Colors.blue),
                      ),
                      SizedBox(height: 20),
                      FormBuilderTextField(
                          name: "email",
                          cursorColor: Colors.blue,
                          controller: emailController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1.0),
                            ),
                            labelStyle: GoogleFonts.lato(color: Colors.blue),
                            labelText: "Email",
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FormBuilderTextField(
                        obscureText: true,
                        name: "password",
                        controller: passwordController,
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1.0),
                          ),
                          labelText: "Password",
                          labelStyle: GoogleFonts.lato(color: Colors.blue),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.white),
                              shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          onPressed: () async {
                            await postLogin(emailController.text,
                                    passwordController.text)
                                .then((value) => {
                                      if (value != null)
                                        {
                                          setState(() {
                                            nama = value.data!.nama;
                                            iduser = value.data!.iduser;
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        MainScreens(
                                                            nama: nama!,
                                                            iduser: iduser!)));
                                          })
                                        }
                                    });
                          },
                          child: Text("Sign In"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: 'Dont Have an Account ? ',
                              style: GoogleFonts.lato(color: Colors.black54)),
                          TextSpan(
                              text: 'Sign Up',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Register()));
                                },
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54))
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
        ]),
      ),
    ));
  }
}
