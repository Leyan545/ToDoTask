// main page for Admin
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:flutter_application/screens/description.dart';
import 'sidedrawer.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_application/user.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_snackbar/flutter_snackbar.dart';
import 'dart:convert'; //convert json into data I can deal with
import 'package:flutter_application/tasks.dart';
import 'addtask.dart';


class TaskPage extends StatefulWidget {
  //const TaskPage({Key? key}) : super(key: key);
  final List<Tasks> tasks;
  TaskPage(this.tasks);


  @override
  _TaskPageState createState() => _TaskPageState(tasks);
}

class _TaskPageState extends State<TaskPage> {

   List<Tasks> tasks;
  _TaskPageState(this.tasks);

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        color: Colors.white70,
        child: TextField(

          decoration: InputDecoration(
              hintText: '    ابحث...'
          ),
          onChanged: (text) {
            text = text.toLowerCase();
            setState(() {
              tasks = tasks.where((e) {
                var name = e.assignee.first_name.toLowerCase();
                return name.contains(text);
              }).toList();
            });
          },
        ),
      ),
    );
  }
   void _showDialog(BuildContext context,index) {
     List<TextEditingController> controls=[];
     for(int i=0;i<1;i++)
       controls.add(TextEditingController());
     showDialog(
       builder: (context) {
         return AlertDialog(
           title: Text('اسم المهمة'),
           content: Container(
             child: Column(
               mainAxisSize: MainAxisSize.min,
               children: [
                 TextField(
                   controller: controls[0],
                   decoration: InputDecoration(
                       hintText: 'اسم المهمة'
                   ),
                 ),

               ],
             ),
           ),
           actions: [
             RaisedButton(
               child: Text('حفظ'),
               onPressed: () {

                 setState(() {
                   tasks[index].title=controls[0].text;
                 });
                 Navigator.of(context).pop();
               },
             ),

           ],
         );
       },
       context: context,
     );
   }


   Future updateTask(String id) async{
    print(id);
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String token =prefs.getString("token")!;
    http.Response response = await http.put(Uri.parse('http://b5ed40e0e7fb.ngrok.io/api/tasks/$id'),
        headers :
        {
          "Content-Type" : "application/json",
          'Authorization': 'token $token'

        });
    if(response.statusCode == 200) {
      var jsonArray = jsonDecode(response.body);
      // mealsList = jsonArray.map((e) => Meals.fromJson(e)).toList();
      return jsonArray;
    }
    else
    {throw Exception("Failed to edit data");}

   }

   void _showDialog1(BuildContext context,index) {
     List<TextEditingController> controls=[];
     for(int i=0;i<1;i++)
       controls.add(TextEditingController());
     showDialog(
       builder: (context) {
         return AlertDialog(
           title: Text('Rate'),
           content: Container(
             child: Column(
               mainAxisSize: MainAxisSize.min,
               children: [
                 TextField(
                   controller: controls[0],
                   decoration: InputDecoration(
                       hintText: 'Rate'
                   ),
                 ),

               ],
             ),
           ),
           actions: [
             RaisedButton(
               child: Text('submit'),
               onPressed: () {

                 setState(() {

                   tasks[index].title=controls[0].text;
                 });
                 Navigator.of(context).pop();
               },
             ),

           ],
         );
       },
       context: context,
     );
   }
   _listItem(index) {
     return Container(
       height: 150,
       margin: EdgeInsets.all(4.0),
       child:Card(
         shadowColor: Colors.black,
         color: Colors.white,

         child: Row(
           children: [
             Padding(
               padding: const EdgeInsets.fromLTRB(2.0,0,0,0),

             ),

             Expanded(
               child: ListTile(
                 title: Text(tasks[index].title),
                 subtitle: Text(tasks[index].details),
                 trailing: Row(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     IconButton(onPressed: () {_showDialog(context,index);}, icon: Icon(Icons.edit)),
                     IconButton(onPressed: () { setState(() {
                       tasks.remove( tasks[index]);
                     });}, icon: Icon(Icons.delete)),

                   ],

                 ),
                 onTap: () {
                   Navigator.push( context,MaterialPageRoute(builder: (context)=> Description(tasks[index])));
                   


                 },
               ),
             ),
           ],
         ),
       ),
     );

   }

/*
trailing: Column(
                     children: [
                       IconButton(onPressed: () {}, icon: Icon(Icons.edit),iconSize: 15),
                       IconButton(onPressed: () {}, icon: Icon(Icons.delete),iconSize: 15),
                     ],
                   ),
                   subtitle: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                     children: [
                       //Text(tasks[index].title,style: TextStyle(fontSize: 13.0,color: Colors.black,fontWeight:FontWeight.bold),),
                      // Text(tasks[index].date,style: TextStyle(fontSize: 18.0,color: Colors.grey[900]),),
                      // Text(tasks[index].assignee.first_name,style: TextStyle(fontSize: 18.0,color: Colors.grey[900]),),
                     ],
                   ),

                   leading: Column(
                     children: [
                       Text(tasks[index].title,style: TextStyle(fontSize: 15.0,color: Colors.black,fontWeight:FontWeight.bold),),
                       Text(tasks[index].date,style: TextStyle(fontSize: 15.0,color: Colors.grey[900]),),
                     ],
                   ),
 */
   //late Future<List<Tasks>> futureAlbum;

  @override
  void initState() {
    super.initState();
    //futureAlbum = fetchTasks();
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("الصفحة الرئيسية", textDirection: TextDirection.rtl),
          centerTitle: true,
        ),
        drawer: const SideDrawer(),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
          itemCount: tasks.length+1,
          itemBuilder: (context, index) {
            if(tasks.isNotEmpty) {
              return index == 0 ? _searchBar() : _listItem(index - 1);
            }
            else
              return Text("لا يوجد مهمات!");
          },),
            ),
            Row(
              children : [
                SizedBox(width: 20),
                Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), padding: EdgeInsets.all(15)),
                      onPressed: (){
                        Navigator.push( context,MaterialPageRoute(builder: (context)=> AddTask()));
                      },
                      child: Icon(Icons.add, size: 28),
                    )
                ),
              ],
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

