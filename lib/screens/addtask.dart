import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var desc = TextEditingController();
  late String taskName;
  late String taskDesc;
  bool _checkbox = false;

  Future createTask(String name) async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    print(token);
    http.Response response = await http.post(Uri.parse("http://b5ed40e0e7fb.ngrok.io/api/tasks/"),
        body: jsonEncode(<String,String>{
          "title":taskName
        }),
        headers :
        {
          "Content-Type" : "application/json;charset=UTF-8",
          'Authorization': 'token $token'
        });
    if(response.statusCode == 200){
      print(response.body);
    } else{
      print("Error");
      print(response.statusCode);
      print(response.headers);
      print(response.body);
    }
    return response;

  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("اضافة مهمة", textDirection: TextDirection.rtl),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: "ادخل اسم المهمة",
                    labelText:  "اسم المهمة"),
            onChanged: (value){
               setState(() {
                 taskName = value;
               });
            },
                  ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "ادخل تفاصيل المهمة",
                      labelText:  "تفاصيل المهمة"),
                  onChanged: (value){
                    setState(() {
                      taskName = value;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "ادخل تفاصيل المهمة",
                      labelText:  "تفاصيل المهمة",
                      contentPadding: const EdgeInsets.symmetric(vertical: 50.0)
                  ),


                  onChanged: (value){
                    setState(() {
                      //taskName = value;
                    });
                  },
                ),
                Row(
                  children: [
                    Checkbox(
                        value: _checkbox,
                        onChanged: (value) {
                          setState(() {
                            _checkbox = !_checkbox;
                          });
                        }
                    ),
                    Text("حالة المهمة")
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        child: Text("حفظ"),
                        onPressed: (){
                          createTask(taskName);
                        },
                      ),
                    ),
                  ]
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
