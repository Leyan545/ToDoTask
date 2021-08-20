import 'dart:convert';
import 'package:flutter_application/tasks.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class Description extends StatefulWidget {

 // const Description({Key? key}) : super(key: key);
  final Tasks tasks;
  Description(this.tasks);

  @override
  _DescriptionState createState() => _DescriptionState(tasks);

}

class _DescriptionState extends State<Description> {

  final Tasks tasks;
  _DescriptionState(this.tasks);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("وصف مهمة", textDirection: TextDirection.rtl),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: <Widget>[
                Row(
                  children: [
                    Text('اسم المهمة'),
                    Text(tasks.title),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('اسم المهمة'),
                    Text(tasks.details),
                  ],
                ),
                Row(
                  children: [
                    Text('اسم المهمة'),
                    Text(tasks.date),
                  ],
                ),
                Row(
                  children: [
                    Text('اسم المهمة'),
                    Text(tasks.creator.first_name),
                    Text(tasks.creator.last_name)
                  ],
                ),
                Row(
                  children: [
                    Text('اسم المهمة'),
                    Text(tasks.assignee.first_name),
                    Text(tasks.assignee.last_name)
                  ],
                ),
                Row(
                  children: [
                    Text('اسم المهمة'),
                    tasks.done?Icon(Icons.check_box):Icon(Icons.check_box_outline_blank),
                  ],
                ),



              ],
            ),
          ),
        ),

      ),
    );
  }
}
