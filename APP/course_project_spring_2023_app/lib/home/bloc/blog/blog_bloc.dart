import 'dart:async';

import 'package:api_repository/api_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:course_project_spring_2023_app/home/bloc/home_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc({required ApiRepository apiRepository})
      : _apiRepository = apiRepository,
        super(BlogState()) {
    on<_BlogsChanged>(_onBlogsChanged);
    on<TokenChanged>(_onTokenChanged);
    _blogsSubscription =
        _apiRepository.blogs.listen((blogs) => add(_BlogsChanged(blogs)));
  }

  final ApiRepository _apiRepository;
  late StreamSubscription<List<Blog>> _blogsSubscription;

  Stream<BlogState> mapEventToState(BlogEvent event) async* {
    if (event is BlogsLoad) {
      yield Loading();

      final generatedItems = await _apiRepository.GetBlogs(token: state.token);
      if (generatedItems is List<Blog>) {
        yield Loaded(generatedItems);
      }
    }

    if (event is BlogsRefresh) {
      yield Refresh();

      final generatedItems = await _apiRepository.GetBlogs(token: state.token);

      if (generatedItems is List<Blog>) {
        yield Loaded(generatedItems);
      }
    }
  }

  @override
  Future<void> close() {
    _blogsSubscription.cancel();
    return super.close();
  }

  void _onBlogsChanged(
    _BlogsChanged event,
    Emitter<BlogState> emit,
  ) async {
    emit(state.copyWith(blogs: event.blogs));
  }

  void _onTokenChanged(
    TokenChanged event,
    Emitter<BlogState> emit,
  ) async {
    await _apiRepository.GetBlogs(token: event.token);
    emit(state.copyWith(token: event.token));
  }
}
