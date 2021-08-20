import 'package:flutter/material.dart';
import 'package:flutter_application/user.dart';
import 'sidedrawer.dart';
import 'adduser.dart';

class ShowUsers extends StatefulWidget {
  //const ShowUsers({Key? key}) : super(key: key);
   final List<User> users;
   ShowUsers(this.users);

  @override
  _ShowUsersState createState() => _ShowUsersState(users);
}

class _ShowUsersState extends State<ShowUsers> {
  List<User> users;
  _ShowUsersState(this.users);

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
              users = users.where((e) {
                var name = e.first_name.toLowerCase();
                return name.contains(text);
              }).toList();
            });
          },
        ),
      ),
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
                title: Text(users[index].date_joined),
                subtitle: Text(users[index].last_name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: () {_showDialog(context,index);}, icon: Icon(Icons.edit)),
                    IconButton(onPressed: () { setState(() {
                      users.remove( users[index]);
                    });}, icon: Icon(Icons.delete)),

                  ],

                ),
                onTap: () {
                },

              ),


            ),


          ],
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
                  users[index].first_name=controls[0].text;



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
                itemCount: users.length+1,
                itemBuilder: (context, index) {
                  if(users.isNotEmpty) {
                    return index == 0 ? _searchBar() : _listItem(index - 1);
                  }
                  else
                    return Text("لا يوجد مستخدمين!");
                },),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), padding: EdgeInsets.all(15)),
                  onPressed: (){
                    Navigator.push( context,MaterialPageRoute(builder: (context)=> AddUser()));
                  },
                  child: Icon(Icons.add, size: 25),
                )
            ),
          ],
        ),
      ),
    );
  }
}

