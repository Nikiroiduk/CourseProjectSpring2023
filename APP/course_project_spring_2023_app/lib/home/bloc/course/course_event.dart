part of 'course_bloc.dart';

@immutable
abstract class CourseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TokenChangedCourse extends CourseEvent {
  TokenChangedCourse(this.token);
  final String token;
  @override
  List<Object> get props => [token];
}

class _CoursesChanged extends CourseEvent {
  _CoursesChanged(this.courses);
  final List<Course> courses;
  @override
  List<Object> get props => [courses];
}

class AddCourseToUser extends CourseEvent {
  AddCourseToUser(this.course);
  final Course course;
  @override
  List<Object> get props => [course];
}

class CourseAdded extends CourseEvent {
  CourseAdded(this.course);
  final Course course;
  @override
  List<Object> get props => [course];
}

class CourseUpdated extends CourseEvent {
  CourseUpdated(this.course);
  final Course course;
  @override
  List<Object> get props => [course];
}

class CourseRemoved extends CourseEvent {
  CourseRemoved(this.course);
  final Course course;
  @override
  List<Object> get props => [course];
}
