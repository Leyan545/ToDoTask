import 'package:flutter_application/user.dart';
class User {
  int id;
  String password;
  String last_login;
  bool is_superuser;
  String username;
  String first_name;
  String last_name;
  String email;
  bool is_staff;
  bool is_active;
  String date_joined;

  User(
      {required this.id, required this.password, required this.last_login, required this.is_superuser, required this.username, required this.first_name, required this.last_name, required this.email, required this.is_staff, required this.is_active, required this.date_joined});


  /*User.fromJson(Map<String, dynamic> json, this.password, this.last_login, this.is_superuser, this.username, this.first_name, this.last_name, this.email, this.is_staff, this.is_active, this.date_joined)
    :
  Map<String, dynamic> toJson() => {
    'name' : first_name,
    'email' : email,
  }; */

  factory User.fromJson(dynamic json) {
    return User(
      id: json['id'],
      password: json['password'],
      last_login: json['last_login'],
      is_superuser: json['is_superuser'],
      username: json['username'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      is_staff: json['is_staff'],
      is_active: json['is_active'],
      date_joined: json['date_joined'],
    );
  }

  @override
  String toString() {
    return 'User{id : $id,password: $password,last_login: $last_login, is_superuser: $is_superuser,username: $username,first_name: $first_name,last_name: $last_name,email: $email,is_staff: $is_staff,is_active: $is_active,date_joined: $date_joined}';
  }
}

/* DON'T FORGET TO PUT THESE
"groups": [], and tasks
"user_permissions": [] */