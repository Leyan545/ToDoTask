
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FetchTasks {
  Future fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    http.Response response = await http.get(
        Uri.parse("http://b86de324d96a.ngrok.io/api/tasks/"),
        headers: {'TokenAuthentication': token}
    );
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData;
    }
    else {
      throw Exception("Failed to load data");
    }
  }
}