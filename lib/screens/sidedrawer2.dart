// side drawer for employer
import 'package:flutter/material.dart';
import 'main.dart';
import 'addtask.dart';
import 'taskpage2.dart';

class SideDrawer2 extends StatefulWidget {
  const SideDrawer2({Key? key}) : super(key: key);

  @override
  _SideDrawer2State createState() => _SideDrawer2State();
}

class _SideDrawer2State extends State<SideDrawer2> {
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TaskPage2(),
                        ));
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddTask(),
                        ));
                  },
                ),
                const Divider(thickness: 2),
                ListTile(
                  title: const Text("المهمات المنجزة",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  leading: Icon(
                    Icons.list_alt,
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
