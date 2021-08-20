
class Creator {
  String first_name;
  String last_name;

  Creator({required this.first_name, required this.last_name});

  factory Creator.fromJson(dynamic json) {
    return Creator(
      first_name: json['first_name'],
      last_name: json['last_name'],
    );
  }

  @override
  String toString() {
    return '{first_name : $first_name,last_name: $last_name}';
  }



}