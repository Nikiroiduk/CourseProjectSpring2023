part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.isNewUser = false,
  });

  final FormzSubmissionStatus status;
  final bool isValid;
  final Username username;
  final Password password;
  final bool isNewUser;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    bool? isValid,
    Username? username,
    Password? password,
    bool? isNewUser,
  }) {
    return LoginState(
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      username: username ?? this.username,
      password: password ?? this.password,
      isNewUser: isNewUser ?? this.isNewUser,
    );
  }

  @override
  List<Object> get props => [status, isValid, username, password, isNewUser];
}
