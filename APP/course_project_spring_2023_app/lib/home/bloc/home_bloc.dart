import 'package:api_repository/api_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:course_project_spring_2023_app/home/home.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

import '../models/models.dart';

part 'home_event.dart';
part 'home_state.dart';

enum HomeTab { blog, course, profile }

enum Gender { male, female }

enum BlogsState { loading, loaded }

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<NewScreenSelected>(_onNewScreenSelected);
    on<IsNewUserChanged>(_onIsNewUserChanged);
    on<UpdateUserData>(_onUpdateUserData);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<WeightChanged>(_onWeightChanged);
    on<HeightChanged>(_onHeightChanged);
    on<BirthDateChanged>(_onBirthDateChanged);
    on<GenderChanged>(_onGenderChanged);
    on<NewUserDataSubmitted>(_onNewUserDataSubmitted);
  }

  void _onNewScreenSelected(
    NewScreenSelected event,
    Emitter<HomeState> emit,
  ) async {
    final value = event._value;
    emit(state.copyWith(
      value: value,
    ));
  }

  void _onIsNewUserChanged(
    IsNewUserChanged event,
    Emitter<HomeState> emit,
  ) async {
    final value = event._value;
    emit(state.copyWith(
      isNewUser: value,
    ));
  }

  void _onUpdateUserData(
    UpdateUserData event,
    Emitter<HomeState> emit,
  ) async {
    final value = event._value;
    emit(state.copyWith(
      user: value,
    ));
  }

  void _onFirstNameChanged(
    FirstNameChanged event,
    Emitter<HomeState> emit,
  ) async {
    final firstName = FirstName.dirty(event._value);
    emit(
      state.copyWith(
          firstName: firstName,
          isDataFieldsValid: Formz.validate(
              [firstName, state.lastName, state.height, state.weight])),
    );
  }

  void _onLastNameChanged(
    LastNameChanged event,
    Emitter<HomeState> emit,
  ) async {
    final lastName = LastName.dirty(event._value);
    emit(
      state.copyWith(
          lastName: lastName,
          isDataFieldsValid: Formz.validate(
              [state.firstName, lastName, state.height, state.weight])),
    );
  }

  void _onWeightChanged(
    WeightChanged event,
    Emitter<HomeState> emit,
  ) async {
    final weight = Weight.dirty(event._value);
    emit(state.copyWith(
        weight: weight,
        isDataFieldsValid: Formz.validate(
            [state.firstName, state.lastName, state.height, weight])));
  }

  void _onHeightChanged(
    HeightChanged event,
    Emitter<HomeState> emit,
  ) async {
    final height = Height.dirty(event._value);
    emit(state.copyWith(
        height: height,
        isDataFieldsValid: Formz.validate(
            [state.firstName, state.lastName, height, state.weight])));
  }

  void _onGenderChanged(
    GenderChanged event,
    Emitter<HomeState> emit,
  ) async {
    final value = event._value;
    emit(state.copyWith(
      gender: value,
    ));
  }

  void _onBirthDateChanged(
    BirthDateChanged event,
    Emitter<HomeState> emit,
  ) async {
    final value = event._value;
    emit(state.copyWith(
      birthDate: value,
    ));
  }

  void _onNewUserDataSubmitted(
    NewUserDataSubmitted event,
    Emitter<HomeState> emit,
  ) async {
    if (state.isDataFieldsValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        var tmp = ApiRepository();
        Person p;
        if (state.user != null) {
          p = state.user as Person;
          p.firstName = state.firstName.value;
          p.lastName = state.lastName.value;
          p.isNewPerson = false;
          p.height = double.parse(state.height.value);
          p.weight = double.parse(state.weight.value);
          p.birthDay = state.birthDate;
          p.gender = state.gender;
          await tmp.UpsertPerson(person: p);
        }
        emit(state.copyWith(
            status: FormzSubmissionStatus.success, isNewUser: false));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
