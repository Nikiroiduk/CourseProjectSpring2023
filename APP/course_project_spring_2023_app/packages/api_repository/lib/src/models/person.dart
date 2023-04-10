class Person {
  Person(this.id, this.token, {this.isNewPerson = false});

  late int id;
  late String username;
  late String token;
  late bool isNewPerson;
}
