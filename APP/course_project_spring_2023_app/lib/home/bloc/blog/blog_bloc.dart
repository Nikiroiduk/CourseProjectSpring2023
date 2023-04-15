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
    on<BlogDeleted>(_onBlogDeleted);
    on<BlogAdded>(_onBlogAdded);
    on<BlogUpdated>(_onBlogUpdated);
    _blogsSubscription =
        _apiRepository.blogs.listen((blogs) => add(_BlogsChanged(blogs)));
  }

  final ApiRepository _apiRepository;
  late StreamSubscription<List<Blog>> _blogsSubscription;

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

  void _onBlogDeleted(BlogDeleted event, Emitter<BlogState> emit) async {
    await _apiRepository.DeleteBlog(token: state.token, blog: event.blog);
    emit(state.copyWith());
  }

  void _onBlogAdded(BlogAdded event, Emitter<BlogState> emit) async {
    await _apiRepository.AddBlog(token: state.token, blog: event.blog);
    emit(state.copyWith(added: state.added + 1));
  }

  void _onBlogUpdated(BlogUpdated event, Emitter<BlogState> emit) async {
    await _apiRepository.UpdateBlog(token: state.token, blog: event.blog);
    emit(state.copyWith());
  }
}
