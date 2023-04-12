import 'dart:async';

import 'package:api_repository/api_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _apiRepository = ApiRepository();
  late Person person;

  Stream<AuthenticationStatus> get status async* {
    //TODO: Check some storage for user token and if token is valud authenricate with it else show signIn/Up screen
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<Object?> logIn({
    required String username,
    required String password,
  }) async {
    var r = await _apiRepository.AuthorizePerson(
        username: username, password: password);
    if (r is Person) {
      _controller.add(AuthenticationStatus.authenticated);
      person = r;
    }
  }

  Future<Object?> signUp({
    required String username,
    required String password,
  }) async {
    var r = await _apiRepository.RegistratePerson(
        username: username, password: password);
    if (r is Person) {
      _controller.add(AuthenticationStatus.authenticated);
      person = r;
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
