import '../../api_repository.dart';

class Course {
  Course({required this.id, required this.name, required this.exercises});

  final int id;
  final String name;
  final List<Exercise> exercises;

  factory Course.fromJson(Map<String, dynamic> json) {
    List<Exercise> result = <Exercise>[];
    for (var element in json["Exercises"]) {
      if (element is Map<String, dynamic>)
        result.add(Exercise.fromJson(element));
    }
    return Course(id: json["Id"], name: json["Name"], exercises: result);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> res = <Map<String, dynamic>>[];
    for (var element in exercises) {
      res.add(element.toJson());
    }

    return <String, dynamic>{
      "Name": name,
      "Exercises": res,
    };
  }

  @override
  String toString() {
    return "Name: $name, Exercises: $exercises";
  }
}
