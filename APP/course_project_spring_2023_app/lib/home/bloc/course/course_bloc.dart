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
    on<CourseAdded>(_onCourseAdded);
    on<CourseUpdated>(_onCourseUpdated);
    on<CourseRemoved>(_onCourseRemoved);
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
    emit(state.copyWith());
  }

  void _onCourseAdded(
    CourseAdded event,
    Emitter<CourseState> emit,
  ) async {
    _apiRepository.AddCourse(token: state.token, course: event.course);
    emit(state.copyWith());
  }

  void _onCourseUpdated(
    CourseUpdated event,
    Emitter<CourseState> emit,
  ) async {
    _apiRepository.UpdateCourse(token: state.token, course: event.course);
    emit(state.copyWith());
  }

  void _onCourseRemoved(
    CourseRemoved event,
    Emitter<CourseState> emit,
  ) async {
    _apiRepository.RemoveCourse(token: state.token, course: event.course);
    emit(state.copyWith());
  }
}
