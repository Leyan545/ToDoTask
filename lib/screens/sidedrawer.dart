// side drawer for Admin
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/tasks.dart';
import 'showusers.dart';
import 'package:flutter_application/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'taskpage.dart';
import 'addtask.dart';
import 'main.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  List <User> users = [];
  List <Tasks> tasks = [];
  var loginpage1 = new LoginPage();


  getData() async {
    LoginPage loginPage = LoginPage();
    //loginPage.fetch();
  }

  Future fetchUsers() async {

    SharedPreferences prefs=await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    print(token);
    http.Response response = await http.get(Uri.parse("http://b5ed40e0e7fb.ngrok.io/api/users/"),
        headers :
        {
          "Content-Type" : "application/json",
          'Authorization': 'token $token'

        });

    if(response.statusCode == 200) {
      var jsonArray = jsonDecode(response.body) as List;
      users= jsonArray.map((element) => User.fromJson(element)).toList();
      print(response.statusCode);
      print(response.body);

    }
    else{
      print(response.statusCode);
      print(response.body);
      //print(response.headers);
    }

    Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context) => ShowUsers(users),));


  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            margin:const EdgeInsets.only(top: 45),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue.withOpacity(0.8),
              child: const Icon(Icons.person, color: Colors.white,size: 70),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                const Divider(thickness: 2),
                ListTile(
                  title: const Text("الرئيسية", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  leading: Icon(
                    Icons.home,
                    color: Colors.blue[500],
                    size: 30,
                  ),
                  onTap: () {

                  },
                ),
                const Divider(thickness: 2),
                ListTile(
                  title: const Text("اضافة مهمة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  leading: Icon(
                    Icons.add_box_rounded,
                    color: Colors.blue[500],
                    size: 30,
                  ),
                  onTap: () {
                    Navigator.push( context,MaterialPageRoute(builder: (context)=> AddTask()));
                  },
                ),
                const Divider(thickness: 2),
                ListTile(
                  title: const Text("قائمة المستخدمين",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  leading: Icon(
                    Icons.library_books,
                    color: Colors.blue[500],
                    size: 30,
                  ),
                  onTap: () {
                    fetchUsers();
                  },
                ),
                const Divider(thickness: 2),
                ListTile(
                  title: const Text("الاعدادات", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  leading: Icon(
                    Icons.settings,
                    color: Colors.blue[500],
                    size: 30,
                  ),
                  /*onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => (),
                        ));
                  }, */
                ),
                const Divider(thickness: 2),
                ListTile(
                  title: const Text("تسجيل الخروج", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  leading: Icon(
                    Icons.logout,
                    color: Colors.blue[500],
                    size: 30,
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

