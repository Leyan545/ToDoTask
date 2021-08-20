import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../tasks.dart';
import '../user.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_snackbar/flutter_snackbar.dart';
import 'dart:convert'; //convert json into data I can deal with
import 'package:dio/dio.dart';
import 'taskpage.dart';
//import 'taskpage2.dart';
//import 'package:animated_text_kit/animated_text_kit.dart';


void main() {
  runApp(
    const MaterialApp(
      home: LoginPage(),
    ),
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final _userName = TextEditingController();
  final _password = TextEditingController();
  List<User> users = [];
  List<Tasks>tasks=[];

  get dio => null;


//void fetch() async {
    //Future
     Future fetch() async {

      SharedPreferences prefs=await SharedPreferences.getInstance();
      String token = prefs.getString('token')!;

    print(token);
    http.Response response = await http.get(Uri.parse("http://b5ed40e0e7fb.ngrok.io/api/tasks/"),
      headers :
      {
        "Content-Type" : "application/json",
        'Authorization': 'token $token'

      });

    if(response.statusCode == 200) {
      var jsonArray = jsonDecode(response.body) as List;
     tasks= jsonArray.map((element) => Tasks.fromJson(element)).toList();
      print(response.statusCode);
      print(response.body);

    }
    else{
      print(response.statusCode);
      print(response.body);
      //print(response.headers);
    }


    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TaskPage(tasks),));


  }



 void p(){
    print(tasks[0]);
 }

  void fetchUser() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    final response = await http.post(
      Uri.parse("http://b5ed40e0e7fb.ngrok.io/api/users/"),
      headers: <String, String>{
        "Content-Type" : "application/json",
        'Authorization': 'token $token'
      },
      body: jsonEncode(<String, String>{
        'username': _userName.text,
        'password' : _password.text,
      }),
    );

    if (response.statusCode == 200 ) {
       User usedUser  = User.fromJson(jsonDecode(response.body));
      if(usedUser.is_superuser){
        fetch();
      }
      else {
       print('mmmmmmmmmmmm');
      }
    }
    else {
      print(response.body);
      throw Exception('Failed to log-in');
    }
  }

  logIn(String username, String password) async {
    if (_userName.text.isNotEmpty && _password.text.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var jsonResponse;
      var res = await http.post(
        // don't forget to make a temporary file to take a link and put it as a variable here!!!!!
        Uri.parse("http://b5ed40e0e7fb.ngrok.io/api/login/"),

        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (res.statusCode == 200) {
        jsonResponse = json.decode(res.body);
        print("Response status: ${res.statusCode}");
        print("Response status : ${res.body}");

        if (jsonResponse != null) {
          setState(() {
            _isLoading = false;
          });
          prefs.setString("token", jsonResponse['token']);
          String? token = prefs.getString('token');
          print(token);
          fetchUser();




    /* Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => TaskPage(tasks)),
                  (Route<dynamic> route) => false); */
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        print("123");
        print("Response status: ${res.body}");
        Fluttertoast.showToast(msg: "خطأ في اسم المستخدم أو كلمة المرور",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
        _clearTextFields();
        //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid password")));
      }
    } else {
      Fluttertoast.showToast(msg: "يجب ملئ جميع الخانات!",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
      //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("blank space is not allowed!")));
    }
  }

  getToken() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      print(token);


  }

  void _clearTextFields (){
    _userName.text = "";
    _password.text = "";
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 80),
          height: 200.0,
          width: 200.0,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(height: 130.0),
              const Text(
                "Global",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    fontSize: 35.0,
                    fontFamily: 'Canterbury'),
              ),
            ],
          ),
        ),
        Form(
            child: Container(
                padding: EdgeInsets.fromLTRB(40, 50, 40, 50),
                child: Column(children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      controller: _userName,
                      textAlign: TextAlign.right,
                      autofocus: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "اسم المستخدم",
                        suffixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      obscureText: true,
                      controller: _password,
                      textAlign: TextAlign.right,
                      autofocus: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "كلمة المرور",
                        suffixIcon: Icon(Icons.password),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    height: 60,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        logIn(_userName.text, _password.text);

                      },

                      //Navigator.push( context,MaterialPageRoute(builder: (context)=> TaskPage2()));

                      //color: Colors.blue,
                      child: const Text("تسجيل الدخول",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      //shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  const SizedBox(height: 100),
                ]))),
      ]),
    ));
  }
}
