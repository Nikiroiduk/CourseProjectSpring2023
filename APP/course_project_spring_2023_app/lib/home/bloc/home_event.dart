part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class NewScreenSelected extends HomeEvent {
  const NewScreenSelected(this._value);

  final HomeTab _value;

  @override
  List<Object> get props => [_value];
}

class IsNewUserChanged extends HomeEvent {
  const IsNewUserChanged(this._value);

  final bool _value;

  @override
  List<Object> get props => [_value];
}

class UpdateUserData extends HomeEvent {
  const UpdateUserData(this._value);

  final Person _value;

  @override
  List<Object> get props => [_value];
}

class FirstNameChanged extends HomeEvent {
  const FirstNameChanged(this._value);

  final String _value;

  @override
  List<Object> get props => [_value];
}

class LastNameChanged extends HomeEvent {
  const LastNameChanged(this._value);

  final String _value;

  @override
  List<Object> get props => [_value];
}

class WeightChanged extends HomeEvent {
  const WeightChanged(this._value);

  final String _value;

  @override
  List<Object> get props => [_value];
}

class HeightChanged extends HomeEvent {
  const HeightChanged(this._value);

  final String _value;

  @override
  List<Object> get props => [_value];
}

class BirthDateChanged extends HomeEvent {
  const BirthDateChanged(this._value);

  final DateTime _value;

  @override
  List<Object> get props => [_value];
}

class GenderChanged extends HomeEvent {
  const GenderChanged(this._value);

  final String _value;

  @override
  List<Object> get props => [_value];
}

class NewUserDataSubmitted extends HomeEvent {
  const NewUserDataSubmitted();
}

class UpdateBlogsRequested extends HomeEvent {
  const UpdateBlogsRequested();
}
