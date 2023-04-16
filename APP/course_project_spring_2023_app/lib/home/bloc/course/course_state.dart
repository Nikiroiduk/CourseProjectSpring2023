part of 'course_bloc.dart';

@immutable
class CourseState {
  CourseState({this.courses = const <Course>[], this.token = ''});

  List<Course> courses;
  String token;

  CourseState copyWith({
    List<Course>? courses,
    String? token,
  }) {
    return CourseState(
      courses: courses ?? this.courses,
      token: token ?? this.token,
    );
  }
}
