import 'dart:convert';

import 'package:intl/intl.dart';

class Person {
  Person({
    required this.id,
    this.token = 'default',
    this.username = 'default',
    this.isNewPerson = true,
    this.firstName = 'default',
    this.lastName = 'default',
    this.birthDay = null,
    this.gender = 'default',
    this.courses = null,
    this.role = 'User',
    this.height = 0,
    this.weight = 0,
  });

  int id;
  String username;
  String token;
  bool isNewPerson;
  String firstName;
  String lastName;
  double height;
  double weight;
  DateTime? birthDay;
  String gender;
  String role;
  late List<Object>? courses; //TODO
  late int age = DateTime.now().year - birthDay!.year;

  final DateFormat _formatter = DateFormat('yyyy-MM-dd');

  void Update(Person person) {
    username = person.username;
    firstName = person.firstName;
    lastName = person.lastName;
    birthDay = person.birthDay;
    isNewPerson = person.isNewPerson;
    gender = person.gender;
    courses = person.courses;
    role = person.role;
  }

  Map<String, dynamic> toJson() {
    return {
      "Username": username,
      "Height": height,
      "Weight": weight,
      "Courses": <Object>[],
      "IsNewUser": isNewPerson,
      "FirstName": firstName,
      "LastName": lastName,
      "BirthDay": _formatter.format(birthDay as DateTime),
      "Gender": gender,
    };
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    if (json['token'] == null)
      return Person(
        id: json['Id'],
        username: json['Username'],
        isNewPerson: json['IsNewUser'] == true,
        firstName: json['FirstName'],
        lastName: json['LastName'],
        birthDay: DateTime.parse(json['BirthDay']),
        gender: json['Gender'],
        role: json['Role'],
        weight: double.parse(json['Weight'].toString()),
        height: double.parse(json['Height'].toString()),
      );
    return Person(
      id: json['Id'],
      token: json['Token'],
      username: json['Username'],
      isNewPerson: json['IsNewUser'] == true,
      firstName: json['FirstName'],
      lastName: json['LastName'],
      birthDay: DateTime.parse(json['BirthDay']),
      gender: json['Gender'],
      role: json['Role'],
      weight: double.parse(json['Weight'].toString()),
      height: double.parse(json['Height'].toString()),
    );
  }

  @override
  String toString() {
    return "Id: $id\nToken: $token\nUsername: $username" +
        "\nFirstName: $firstName\nLastName: $lastName\n" +
        "Role: $role\nIsNewPerson: $isNewPerson";
  }
}
