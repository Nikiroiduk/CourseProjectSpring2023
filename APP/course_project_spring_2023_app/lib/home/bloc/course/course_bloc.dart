import 'dart:async';

import 'package:api_repository/api_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc({required ApiRepository apiRepository})
      : _apiRepository = apiRepository,
        super(CourseState()) {
    on<_CoursesChanged>(_onCoursesChanged);
    on<TokenChangedCourse>(_onTokenChangedCourse);
    on<AddCourseToUser>(_onAddCourseToUser);
    _blogsSubscription = _apiRepository.courses
        .listen((courses) => add(_CoursesChanged(courses)));
  }

  final ApiRepository _apiRepository;
  late StreamSubscription<List<Course>> _blogsSubscription;

  void _onCoursesChanged(
    _CoursesChanged event,
    Emitter<CourseState> emit,
  ) async {
    emit(state.copyWith(courses: event.courses));
  }

  void _onTokenChangedCourse(
    TokenChangedCourse event,
    Emitter<CourseState> emit,
  ) async {
    await _apiRepository.GetCourses(token: event.token);
    emit(state.copyWith(token: event.token));
  }

  void _onAddCourseToUser(
    AddCourseToUser event,
    Emitter<CourseState> emit,
  ) async {
    //TODO: Call add course to a user
    emit(state.copyWith());
  }
}
