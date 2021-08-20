
class Assignee {
  String first_name;
  String last_name;

  Assignee({required this.first_name, required this.last_name});

  factory Assignee.fromJson(dynamic json) {
    return Assignee(
      first_name: json['first_name'],
      last_name: json['last_name'],
    );
  }

  @override
  String toString() {
    return '{first_name : $first_name,last_name: $last_name}';
  }



}