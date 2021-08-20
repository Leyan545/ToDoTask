// main page for employers
import 'package:flutter/material.dart';
import 'sidedrawer2.dart';

class TaskPage2 extends StatefulWidget {
  const TaskPage2({Key? key}) : super(key: key);

  @override
  _TaskPage2State createState() => _TaskPage2State();
}

class _TaskPage2State extends State<TaskPage2> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("الصفحة الرئيسية", textDirection: TextDirection.rtl),
          centerTitle: true,
        ),
        drawer: const SideDrawer2(),
      ),
    );
  }
}

