part of 'home_bloc.dart';

@immutable
class HomeState extends Equatable {
  const HomeState({
    this.user,
    this.value = HomeTab.profile,
    this.isNewUser = false,
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.isDataFieldsValid = true,
    this.birthDate,
    this.weight = const Weight.pure(),
    this.height = const Height.pure(),
    this.gender = '',
    this.status = FormzSubmissionStatus.initial,
    this.blogs = const <Blog>[],
  });

  final Person? user;
  final HomeTab value;
  final bool isNewUser;
  final FirstName firstName;
  final LastName lastName;
  final bool isDataFieldsValid;
  final DateTime? birthDate;
  final Weight weight;
  final Height height;
  final String gender;
  final FormzSubmissionStatus status;
  final List<Blog> blogs;

  @override
  List<Object?> get props => [
        user,
        value,
        isNewUser,
        firstName,
        lastName,
        isDataFieldsValid,
        birthDate,
        weight,
        height,
        gender,
        status,
        blogs,
      ];

  HomeState copyWith({
    Person? user,
    HomeTab? value,
    bool? isNewUser,
    FirstName? firstName,
    LastName? lastName,
    bool? isDataFieldsValid,
    DateTime? birthDate,
    Weight? weight,
    Height? height,
    String? gender,
    FormzSubmissionStatus? status,
    List<Blog>? blogs,
  }) {
    return HomeState(
      user: user ?? this.user,
      value: value ?? this.value,
      isNewUser: isNewUser ?? this.isNewUser,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isDataFieldsValid: isDataFieldsValid ?? this.isDataFieldsValid,
      birthDate: birthDate ?? this.birthDate,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      blogs: blogs ?? this.blogs,
    );
  }
}
