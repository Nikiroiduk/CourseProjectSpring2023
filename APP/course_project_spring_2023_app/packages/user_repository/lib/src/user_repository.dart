import 'dart:async';

import 'models/models.dart';
import 'package:uuid/uuid.dart';
import 'package:api_repository/api_repository.dart';

enum UserStatus { admin, user, newUser }

class UserRepository {
  final _controller = StreamController<UserStatus>();

  void SetPerson(Person person) {
    _person = person;
  }

  late Person _person;

  Stream<UserStatus> get status async* {
    yield* _controller.stream;
  }
}
