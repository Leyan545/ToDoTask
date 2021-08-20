import 'user.dart';
import 'creator.dart';
import 'assignee.dart';

class Tasks {
  int id;
  Creator creator;
  Assignee assignee;
  String title;
  String details;
  String date;
  bool done;


  Tasks(
      {required this.id,required this.creator, required this.assignee, required this.title, required this.details, required this.date, required this.done});

  factory Tasks.fromJson(dynamic json) {
    return Tasks(
      id: json['id'],
      creator:Creator.fromJson(json['creator']),
      assignee: Assignee.fromJson(json['assignee']),
      title: json['title'],
      details: json['details'],
      date: json['date'],
      done: json['done'],
    );
  }

  @override
  String toString() {
    return 'Task{id : $id,title: $title,details: $details, date: $date,done: $done}';
  }



}